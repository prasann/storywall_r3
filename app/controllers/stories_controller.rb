class StoriesController < ApplicationController

  before_filter :authenticate_user! ,:except =>[:index,:show]
  before_filter :load_story, :only=> [:edit,:update,:show,:destroy]
  def index
    if params[:status]
      @stories =Story.find(:all, :conditions => { :status => params[:status] })
    else
      @stories = Story.all
    end
  end

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.build(params[:story])
    if @story.save()
      redirect_to stories_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    @story.updated_by = current_user.email

    if @story.update_attributes(params[:story])
      redirect_to story_path(@story)
    else
      render :edit
    end
  end

  def destroy
    @story.delete()
    redirect_to stories_path
  end

  private
  def load_story
    @story = Story.find(params[:id])
  end

end

require 'spec_helper'


describe StoriesController do
  def fake_sign_in
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    before do
      get :index
    end

    it { should assign_to(:stories) }
    it { should respond_with(:success) }
    it { should render_template(:index) }

    it "should search for stories with a certain status" do
    	story1=FactoryGirl.create(:story,user: @user)
    	story2=FactoryGirl.create(:story,user: @user)
    	story3=FactoryGirl.create(:story,status: "Dev Done",user: @user)
    	get :index, status:"Dev Done"
    	assigns(:stories).should eq(story3)
    end

  end

  describe "GET new " do
    before do
      fake_sign_in
      get :new
    end
    it { should assign_to(:story) }
    it { should render_template(:new) }
  end

  describe "POST create" do
    before do
      fake_sign_in
    end

    it "creates a new story" do
      lambda{post :create, :story => FactoryGirl.attributes_for(:story)}.should change(Story,:count).by(1)
    end

    it "renders the new form on error" do
      expect {
        post :create, story: FactoryGirl.attributes_for(:story , status: "dead")
      }.to change(Story,:count).by(0)
      should render_template(:new)
    end
  end

  describe "GET edit" do

    before do
      fake_sign_in
      @story = FactoryGirl.create(:story, user: @user)
      get :edit, id: @story.id
    end

    it { should assign_to(:story) }
    it { should render_template(:edit) }
  end

  describe "PUT update" do
    before do
      fake_sign_in
      @story = FactoryGirl.create(:story, user: @user)
    end

    it "should change the attributes of a story" do
      lambda{
        put :update, id: @story.id, :story => {:title => "New Title"}
        @story.reload
      }.should change(@story,:title).to("New Title")
    end

    it "should show the edit page in case of errors" do
      put :update, id: @story.id, :story => {:status => "New Title"}
      should render_template(:edit)
    end

    it "should indicate the user who updated the record" do
      put :update, id: @story.id, :story => {:title => "New Title"}
      @story.reload
      @story.updated_by.should == @user.email
    end
  end

  describe "GET show" do
    before do
      @user = FactoryGirl.create(:user)
      @story = FactoryGirl.create(:story, user: @user)
      get :show, id: @story.id
    end
    it { should assign_to(:story) }
    it { should render_template(:show) }
  end
  describe "DELETE destroy" do
    it "deletes the story" do
      fake_sign_in
      @story = FactoryGirl.create(:story, user: @user)
      expect {
        delete :destroy, id:@story.id
      }.to change(Story,:count).by(-1)
    end
  end

end

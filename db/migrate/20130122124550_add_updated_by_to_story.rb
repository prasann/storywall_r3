class AddUpdatedByToStory < ActiveRecord::Migration
  def change
  	add_column :stories, :updated_by, :string
  end
end

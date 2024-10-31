class AddIsPublishedToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :is_published, :boolean, default: false
  end
end

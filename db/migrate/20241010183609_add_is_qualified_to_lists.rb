class AddIsQualifiedToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :is_qualified, :boolean
  end
end

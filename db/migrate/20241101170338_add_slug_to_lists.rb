class AddSlugToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :slug, :string
  end
end

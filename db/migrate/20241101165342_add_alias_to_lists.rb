class AddAliasToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :alias, :string
  end
end

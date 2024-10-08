class CreateListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :list_items do |t|
      t.references :list, null: false, foreign_key: true
      t.string     :name
      t.text       :description
      t.string     :url

      t.timestamps
    end
  end
end

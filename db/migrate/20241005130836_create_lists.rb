class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.references :family, null: false, foreign_key: true
      t.string     :name
      t.string     :age
      t.string     :gender
      t.string     :gift_card_store

      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text   :description
      t.string :slug

      t.timestamps
    end
  end
end

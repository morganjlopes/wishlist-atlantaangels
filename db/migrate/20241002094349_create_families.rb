class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.references :event, null: false, foreign_key: true, index: true
      t.string     :name
      t.string     :phone
      t.string     :email
      t.string     :address
      t.string     :holiday
      t.boolean    :wrap_gifts
      t.integer    :household_caregivers_count
      t.integer    :household_children_count
      t.string     :slug

      t.timestamps
    end
  end
end

class CreateSponsors < ActiveRecord::Migration[7.0]
  def change
    create_table :sponsors do |t|
      t.string :full_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :slug
      t.uuid   :uuid

      t.timestamps
    end
  end
end

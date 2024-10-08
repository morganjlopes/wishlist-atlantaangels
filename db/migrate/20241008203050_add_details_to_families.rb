class AddDetailsToFamilies < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :is_attending,         :boolean
    add_column :families, :attendance_selection, :string
  end
end

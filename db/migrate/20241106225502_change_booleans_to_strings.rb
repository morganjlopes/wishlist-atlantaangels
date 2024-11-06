class ChangeBooleansToStrings < ActiveRecord::Migration[7.0]
  def change
    change_column :families, :wrap_gifts, :string
    change_column :families, :is_attending, :string
  end
end

class AddIsSupportRequestedToFamilies < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :is_support_requested, :boolean
  end
end

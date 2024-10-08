class AddListsCompletedAtToFamilies < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :lists_completed_at, :datetime
  end
end

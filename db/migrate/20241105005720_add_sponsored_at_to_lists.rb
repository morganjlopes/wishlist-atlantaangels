class AddSponsoredAtToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :sponsored_at, :datetime
  end
end

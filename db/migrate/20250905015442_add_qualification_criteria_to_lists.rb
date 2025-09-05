class AddQualificationCriteriaToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :qualification_criteria, :string
  end
end

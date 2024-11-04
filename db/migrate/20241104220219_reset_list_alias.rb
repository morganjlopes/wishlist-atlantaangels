class ResetListAlias < ActiveRecord::Migration[7.0]
  def change
    List.all.each do |list|
      list.update(alias: nil)
    end
  end
end

class ChangeItemsColumnItemToItemType < ActiveRecord::Migration[5.1]
  def change
    change_table :items do |t|
     t.rename :type, :item_type
   end
  end
end

class ChangeItemsColumnCatagoryToCategory < ActiveRecord::Migration[5.1]
  def change
    change_table :items do |t|
     t.rename :catagory, :category
   end
  end
end

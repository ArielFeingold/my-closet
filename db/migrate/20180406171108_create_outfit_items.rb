class CreateOutfitItems < ActiveRecord::Migration[5.1]
  def change
    create_table :outfit_items do |t|
      t.integer :outfit_id
      t.integer :item_id
    end
  end
end

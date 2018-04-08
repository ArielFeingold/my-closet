class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :catagory
      t.string :type
      t.string :color
      t.integer :user_id
    end
  end
end

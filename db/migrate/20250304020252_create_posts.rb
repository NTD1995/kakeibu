class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :content,  null: false
      t.integer :price,   null: false
      t.integer :category,null: false      
      t.text :memo
      t.timestamps
    end
  end
end

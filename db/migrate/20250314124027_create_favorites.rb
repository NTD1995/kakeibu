class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer    :user_id
      t.integer    :admin_id
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end

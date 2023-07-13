class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :author, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end

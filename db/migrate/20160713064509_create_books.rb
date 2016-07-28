class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :isbn ,null: false
      t.string :author
      t.decimal :price
      t.string :img_url
      t.text :description
    end
    add_index :books, :isbn, unique: true
  end
end

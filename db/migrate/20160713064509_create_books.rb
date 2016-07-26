class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books,:id => false do |t|
      t.string :name
      t.integer :isbn ,null: false
      t.string :author
      t.decimal :price
      t.string :img_url
      t.text :description
      t.string :id
    end
    add_index :books, :isbn, unique: true
  end
end

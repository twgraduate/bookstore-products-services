class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :isbn
      t.string :author
      t.decimal :price
      t.string :img_url
      t.text :description
    end
  end
end

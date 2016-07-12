class CreateTests < ActiveRecord::Migration[5.0]
  def change
    create_table :tests do |t|
      t.string :pra1
      t.string :pra2
      t.string :pra3

      t.timestamps
    end
  end
end

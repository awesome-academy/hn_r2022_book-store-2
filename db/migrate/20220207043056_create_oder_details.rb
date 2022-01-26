class CreateOderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :oder_details do |t|
      t.integer :quantity
      t.string :deli_receiver
      t.string :deli_address
      t.string :deli_phone
      t.decimal :total_price
      t.references :order, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end

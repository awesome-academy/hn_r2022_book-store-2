class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :status, limit: 1
      t.datetime :shiped_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

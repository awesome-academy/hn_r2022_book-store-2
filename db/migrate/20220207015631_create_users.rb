class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :phone
      t.string :password_digest
      t.string :activation_digest
      t.integer :activated
      t.string :reset_digest
      t.string :remember_digest
      t.datetime :activated_at
      t.datetime :reset_sent_at
      t.integer :role, limit: 1, default: 0

      t.timestamps
    end
  end
end

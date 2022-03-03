class DeleteColumnsOfUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :email, :string
    remove_column :users, :password_digest, :string
    remove_column :users, :activation_digest, :string
    remove_column :users, :activated, :integer
    remove_column :users, :activated_at, :datetime
    remove_column :users, :reset_digest, :string
    remove_column :users, :remember_digest, :string
    remove_column :users, :reset_sent_at, :datetime
  end
end

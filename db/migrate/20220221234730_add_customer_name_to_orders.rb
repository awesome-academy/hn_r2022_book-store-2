class AddCustomerNameToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :customer_name, :string
  end
end

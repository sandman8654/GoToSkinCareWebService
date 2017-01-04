class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :userid
      t.integer :productid
      t.integer :amount
      t.datetime :order_datetime

      t.timestamps
    end
  end
end

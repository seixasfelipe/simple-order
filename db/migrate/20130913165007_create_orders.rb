class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.timestamp :date
      t.decimal :subtotal
      t.timestamps
    end
  end
end

class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.string  :name
      t.decimal :total_price
      t.references :order, index: true
      t.timestamps
    end
  end
end

class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string  :name
      t.integer :qty
      t.decimal :unit_price
      t.references :line_item, index: true
      t.timestamps
    end
  end
end

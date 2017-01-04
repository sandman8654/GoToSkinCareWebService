class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :price
      t.integer :price_currency_id
      t.string :detail
      t.string :image_url_small
      t.string :image_url_medium
      t.string :image_url_large

      t.timestamps
    end
  end
end

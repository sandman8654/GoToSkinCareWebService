class CreateAddressLists < ActiveRecord::Migration[5.0]
  def change
    create_table :address_lists do |t|
      t.integer :country_code
      t.string :street
      t.string :street_2
      t.string :suburb
      t.string :state
      t.integer :postcode

      t.timestamps
    end
  end
end

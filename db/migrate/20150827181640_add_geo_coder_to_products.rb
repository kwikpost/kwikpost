class AddGeoCoderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :location, :string
    add_column :products, :latitude, :float
    add_column :products, :longitude, :float
  end
end

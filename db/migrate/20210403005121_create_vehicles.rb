class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.string :vin
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end

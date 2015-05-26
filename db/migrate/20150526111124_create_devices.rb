class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :mac_address, limit: 8, null: false
      t.string :name

      t.timestamps null: false
    end

    add_index :devices, :mac_address, unique: true
  end
end

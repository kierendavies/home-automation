class AddMobileToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :mobile, :boolean
  end
end

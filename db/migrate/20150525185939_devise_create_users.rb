class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## LDAP authenticatable
      t.string :uid,                null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at
      t.string :remember_token

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :users, :uid,                  unique: true
  end
end

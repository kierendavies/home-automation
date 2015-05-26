class User < ActiveRecord::Base
  has_many :devices

  devise :ldap_authenticatable, :rememberable, :trackable
end

class User < ActiveRecord::Base
  has_many :devices

  devise :ldap_authenticatable, :rememberable, :trackable

  def mobile_devices
    devices.where(mobile: true).order(last_seen_at: :desc)
  end

  def last_seen_at
    mobile_devices.empty? ? nil : mobile_devices.first.last_seen_at
  end

  def at_home?
    !last_seen_at.nil? && last_seen_at >= 10.minutes.ago
  end
end

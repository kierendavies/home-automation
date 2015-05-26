require 'date'
require 'home_automation/router'

scheduler = Rufus::Scheduler.singleton

scheduler.every '1m' do
  Rails.logger.info 'Querying attached devices'
  begin
    now = DateTime.now
    HomeAutomation::Router.attached_mac_addresses.each do |mac_address|
      device = Device.find_or_create_by mac_address: mac_address
      device.update last_seen_at: now
    end
  rescue HomeAutomation::Router::RouterError => e
    Rails.logger.warn "Failed to query attached devices: #{e.message}"
  end
end

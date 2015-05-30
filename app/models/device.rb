require_dependency 'home_automation/router'

class Device < ActiveRecord::Base
  belongs_to :user

  def mac_address= address
    if address.is_a? String
      @mac_address = HomeAutomation::Router.mac_address_s_to_i address
    else
      @mac_address = address
    end
    write_attribute(:mac_address, @mac_address)
  end

  def mac_address_s
    HomeAutomation::Router.mac_address_i_to_s mac_address
  end

  def mac_address_s= address
    mac_address = HomeAutomation::Router.mac_address_s_to_i address
  end
end

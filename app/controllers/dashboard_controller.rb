require 'home_automation/router'

class DashboardController < ApplicationController
  def index
    @mac_addresses = HomeAutomation::Router.attached_mac_addresses
  end
end

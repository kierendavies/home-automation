require_dependency 'home_automation/router'

class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @mac_addresses = HomeAutomation::Router.attached_mac_addresses
  end
end

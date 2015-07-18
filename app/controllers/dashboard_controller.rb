require_dependency 'home_automation/router'

class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all.order(uid: :asc)
  end
end

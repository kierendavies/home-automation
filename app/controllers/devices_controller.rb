class DevicesController < ApplicationController
  before_filter :authenticate_user!

  def list_all
    @devices = Device.all
  end

  def list_for_user
    @devices = User.find_by!(uid: params[:uid]).devices
  end
end

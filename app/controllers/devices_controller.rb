class DevicesController < ApplicationController
  before_filter :authenticate_user!

  def list_all
    @devices = Device.all
  end

  def list_for_user
    @devices = User.find_by!(uid: params[:uid]).devices
  end

  def update
    if params[:id]
      device = Device.find(params[:id])
    else
      device = Device.new
      device.mac_address_s = params[:mac_address]
    end

    owner = params[:owner] || params[:uid]
    device.user = owner ? User.find_by!(uid: owner) : nil

    device.name = params[:name]

    device.save!

    if params[:uid]
      redirect_to user_devices_path(params[:uid])
    else
      redirect_to all_devices_path
    end
  end
end

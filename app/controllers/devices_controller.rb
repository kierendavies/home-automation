class DevicesController < ApplicationController
  before_filter :authenticate_user!

  def list_all
    @devices = Device.all.order(last_seen_at: :desc)
  end

  def list_for_user
    @user = User.find_by!(uid: params[:uid])
    @devices = @user.devices.order(last_seen_at: :desc)
  end

  def update
    if params[:id]
      device = Device.find(params[:id])
    else
      device = Device.new
      device.mac_address_s = params[:mac_address]
    end

    begin
      device.user = (params[:owner].nil? || params[:owner].empty?) ? nil : User.find_by!(uid: params[:owner])
      device.name = params[:name]
      device.mobile = params[:mobile]
      device.save!
    rescue => e
      flash[:error] = e.message
    end

    redirect_to :back
  end
end

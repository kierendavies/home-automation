class DevicesController < ApplicationController
  before_filter :authenticate_user!

  def list
    puts params.inspect
    @devices = params[:uid] ? User.find_by!(uid: params[:uid]).devices : Device.all
  end
end

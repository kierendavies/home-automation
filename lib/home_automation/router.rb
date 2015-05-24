require 'net/http'
require 'uri'

module HomeAutomation
  module Router
    def self.attached_mac_addresses
       uri = URI.parse("http://www.routerlogin.com/DEV_device.htm")
       http = Net::HTTP.new(uri.host, uri.port)
       request = Net::HTTP::Get.new(uri.request_uri)
       request.basic_auth(Rails.application.secrets.router_username, Rails.application.secrets.router_password)
       response = http.request(request)

       macs = response.body.scan /(?:[0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}/
       return macs
    end
  end
end

require 'net/http'
require 'uri'

module HomeAutomation
  module Router

    class RouterError < StandardError
    end

    class DeviceLockedError < RouterError
    end

    class RequestError < RouterError
    end

    def self.get_page path
      uri = URI.parse("http://www.routerlogin.com/#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      request.basic_auth(Rails.application.secrets.router_username, Rails.application.secrets.router_password)
      response = http.request(request)

      raise RequestError.new response.code unless response.code == '200'
      raise DeviceLockedError if response.body =~ /is managing this device/

      response.body
    end

    def self.get_page_and_log_out path
      body = get_page path
      get_page 'LGO_logout.htm'
      body
    end

    def self.attached_mac_addresses
       get_page_and_log_out('DEV_device.htm').scan /(?:[0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}/
    end
  end
end

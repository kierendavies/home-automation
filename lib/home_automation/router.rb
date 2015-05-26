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

    def self.mac_address_s_to_i address
      address_i = 0
      address.split(/[:-]/).each_with_index do |octet, i|
        address_i += octet.to_i(16) << ((5 - i) * 8)
      end
      address_i
    end

    def self.mac_address_i_to_s address
      5.downto(0).map {|i| ((address >> i * 8) % 256).to_s(16).rjust(2, '0')}.join(':').upcase
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
       get_page_and_log_out('DEV_device.htm').scan(/(?:[0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}/).map do |address|
         mac_address_s_to_i address
       end
    end
  end
end

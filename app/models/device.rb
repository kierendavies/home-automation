class Device < ActiveRecord::Base
  belongs_to :user

  def mac_address= addr
    if addr.is_a? String
      @mac_address = 0
      addr.split(/[:-]/).each_with_index do |octet, i|
        @mac_address += octet.to_i(16) << ((5 - i) * 8)
      end
    else
      @mac_address = addr
    end
    write_attribute(:mac_address, @mac_address)
  end

  def mac_address_s
    5.downto(0).map {|i| ((mac_address >> i * 8) % 256).to_s(16)}.join(':')
  end
end

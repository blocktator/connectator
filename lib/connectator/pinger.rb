require 'timeout'

module Connectator
  module Pinger
    def self.ping?(host, timeout = 1)
      Timeout::timeout(timeout) do
        `#{system_ping_command(host, timeout)}`
        ($?.exitstatus == 0)
      end
    rescue Timeout::Error
      false
    end

    private

    def self.system_ping_command(host, timeout)
      "ping #{host} -W #{timeout} -c 1 2> /dev/null"
    end
  end 
end

# Include this module in any connection that you want to use
# DBI and the DBIProxy

module Connectator
  module UsingDBIProxy

    private

    def new_system_connection_proxy
      DBIProxy.new(open)
    end

    def open
      DBI.connect(connection_string)
    end
  end
end


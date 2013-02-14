module Connectator
  module Oracle
    class Connection < Base::Connection
      
      def connection_string
        "DBI:OCI8://#{connection_params.server}:#{connection_params.port}/#{connection_params.instance}"
      end

      private

      # This is overrides the Base open method, because username and password
      # are passed in through the DBI OCI8 driver
      def open
        DBI.connect(connection_string,
                    connection_params.username,
                    connection_params.password)
      end
    end
  end
end

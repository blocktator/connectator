module Connectator
  module DB2
    class Connection < Base::Connection
      include UsingDBIProxy
      
      def initialize(opts = {})
        connection_params.driver   = 'DB2' 
        connection_params.protocol = 'TCPIP'
        connection_params.database = opts[:database]
        super(opts)
      end
      
      def connection_string
        "DBI:ODBC:#{connection_params_list}"
      end
    
      private

      def connection_params_hash
        {
         "DRIVER"      => connection_params.driver,
         "PROTOCOL"    => connection_params.protocol,
         "HOSTNAME"    => connection_params.server,
         "PORT"        => connection_params.port,
         "DATABASE"    => connection_params.database,
         "UID"         => connection_params.username,
         "PWD"         => connection_params.password
        }
      end
    end
  end
end

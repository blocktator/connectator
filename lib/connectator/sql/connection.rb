module Connectator
  module Sql
    class Connection < Base::Connection
    
      def initialize(opts = {})
        connection_params.tds_version = '8.0'
        connection_params.database    = 'master' 
        connection_params.driver      = 'FreeTDS' 
        super(opts)
      end
      
      def connection_string
        "DBI:ODBC:#{connection_params_list}"
      end

      private

      def server_instance_string
        ServerInstanceString.build(connection_params.server, connection_params.instance)
      end

      def connection_params_hash
        {
         "DRIVER"      => connection_params.driver,
         "TDS_Version" => connection_params.tds_version,
         "SERVER"      => server_instance_string,
         "Port"        => connection_params.port,
         "DATABASE"    => connection_params.database,
         "UID"         => connection_params.username,
         "PWD"         => connection_params.password
        }
      end
    end
  end
end

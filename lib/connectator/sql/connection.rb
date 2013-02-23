module Connectator
  module SQL
    class Connection < Base::Connection
      include UsingDBIProxy
    
      def initialize(opts = {})
        super(opts)
        connection_params.driver      = 'FreeTDS' 
        connection_params.tds_version = opts[:tds_version] || '8.0'
        connection_params.database    = opts[:database]    || 'master' 
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
         "PORT"        => connection_params.port,
         "DATABASE"    => connection_params.database,
         "UID"         => connection_params.username,
         "PWD"         => connection_params.password
        }
      end
    end
  end
end

module Connectator
  module Sybase 
    class Connection < Base::Connection

      def initialize(opts = {})
        connection_params.tds_version = '5.0'
        connection_params.database    = 'master'
        connection_params.driver      = 'FreeTDS' 
        super(opts)
      end
      
      def connection_string
        "DBI:ODBC:#{connection_params_list}"
      end

      private
     
      def connection_params_hash
        {
         "DRIVER"      => connection_params.driver,
         "TDS_Version" => connection_params.tds_version,
         "SERVER"      => connection_params.server,
         "Port"        => connection_params.port,
         "DATABASE"    => connection_params.database,
         "UID"         => connection_params.username,
         "PWD"         => connection_params.password
        }
      end
    end
  end
end

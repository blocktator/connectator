module Connectator
  module Mysql 
    class Connection < Base::Connection

      def initialize(opts = {})
        connection_params.driver   = 'MySQL'
        connection_params.option   = opts[:option]   || '3'
        connection_params.port     = opts[:port]     || '3306'
        connection_params.database = opts[:database] || ''
        super(opts)
      end
      
      def connection_string
        "DBI:ODBC:#{connection_params_list}"
      end

      private
     
      def connection_params_hash
        {
         "DRIVER"      => connection_params.driver,
         "Server"      => connection_params.server,
         "Port"        => connection_params.port,
         "Database"    => connection_params.database,
         "User"        => connection_params.username,
         "Password"    => connection_params.password,
         "Option"      => connection_params.option
        }
      end
    end
  end
end

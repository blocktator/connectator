module Connectator
  module Mysql 
    class Connection < Base::Connection
      include UsingDBIProxy

      def initialize(opts = {})
        connection_params.driver   = 'MySQL'
        # See this url for options flags
        # http://dev.mysql.com/doc/refman/5.0/en/connector-odbc-configuration-connection-parameters.html#codbc-dsn-option-flags
        connection_params.option   = opts[:option]   || '3'
        connection_params.database = opts[:database] || nil
        super(opts)
      end
      
      def connection_string
        "DBI:ODBC:#{connection_params_list}"
      end

      private
     
      def connection_params_hash
        {
         "DRIVER"      => connection_params.driver,
         "SERVER"      => connection_params.server,
         "PORT"        => connection_params.port,
         "DATABASE"    => connection_params.database,
         "UID"         => connection_params.username,
         "PWD"         => connection_params.password,
         "OPTION"      => connection_params.option
        }
      end
    end
  end
end

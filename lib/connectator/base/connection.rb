require 'ostruct'

module Connectator
  module Base
    class Connection
      attr_reader :connection_error

      def initialize(opts = {})
        raise "Connection Options are required" if opts.empty?
        connection_params.server   = opts[:server]
        connection_params.instance = opts[:instance]
        connection_params.port     = opts[:port]
        connection_params.username = opts[:username]
        connection_params.password = opts[:password]
        return self
      end

      def connection_params
        @connection_params ||= OpenStruct.new
      end

      def system_connection
        @system_connection ||= DBIProxy.new(open)
      end
      
      # proxies all other method calls to the DBIProxy
      def method_missing(method, *args, &blk)
        system_connection.send(method, *args, &blk)
      end

      def valid?
        ping? && valid_system_connection?
      end

      def ping?
        if Pinger.ping?(connection_params.server, 3)
          true
        else
          @connection_error = "Could not ping: #{connection_params.server}"
          false
        end
      end

      def valid_system_connection?
        system_connection.connection
        true
      rescue => e
        @connection_error = e.message
        false
      end
      
      def connection_string
        raise 'Abstract Method'
      end

      private 
      
      def open
        DBI.connect(connection_string)
      end

      def connection_params_list
        connection_params_hash.map { |k,v| "#{k}=#{v}"}.join(';')
      end
      
      def connection_params_hash
        raise 'Abstract Method'
      end
    end
  end
end

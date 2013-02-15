module Connectator
  module Base
    class Connection
      attr_reader :error

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

      def valid?
        ping? && valid_system_connection?
      end

      def ping?
        if Pinger.ping?(connection_params.server, 3)
          true
        else
          @error = "Could not ping: #{connection_params.server}"
          false
        end
      end

      def valid_system_connection?
        system_connection_proxy.connection
        true
      rescue => e
        @error = e.message
        false
      end

      # Proxies all other method calls to the system connection
      # See the DBIProxy for specific methods exposed
      def method_missing(method, *args, &blk)
        system_connection_proxy.send(method, *args, &blk)
      end
      
      def connection_string
        raise 'Abstract Method'
      end

      private 
     
      # TBD: not sure exactly how reload will be exposed 
      def system_connection_proxy(reload = false)
        if reload
          @system_connection_proxy = new_system_connection_proxy 
        else
          @system_connection_proxy ||= new_system_connection_proxy
        end
      end
      
      def new_system_connection_proxy
        raise 'Abstract Method'
      end

      def open
        raise 'Abstract Method'
      end

      def connection_params_list
        connection_params_hash.reject {|k,v| v.nil? }.map { |k,v| "#{k}=#{v}"}.join(';')
      end
      
      def connection_params_hash
        raise 'Abstract Method'
      end
    end
  end
end

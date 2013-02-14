module Connectator
  module Sql
    class Connection < Base::Connection
      class ServerInstanceString
        def self.build(server, instance)
          new(server, instance).server_string
        end

        def initialize(server, instance)
          @server   = server
          @instance = instance
        end        

        def server_string
          "#{@server}#{server_instance}"
        end
        
        private

        def server_instance
          "\\#{instance_name}" unless instance_name.to_s.strip.empty?
        end

        def instance_name
          @instance =~ /\w+\\([\w\$]+)$/; $1
        end
      end        
    end
  end
end

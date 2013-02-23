module Connectator
  class Factory

    # connectator_params object must respond to:
    # * kind (Oracle, Sql, Sybase, DB2)
    # * server
    # * instance
    # * port
    # * username
    # * password
    #
    def self.build(connectator_params)
      return self.new(connectator_params).connection
    end

    attr_reader :connectator_params

    def initialize(connectator_params)
      @connectator_params = connectator_params
    end

    def connection(additional_params = {})
      connection_class.new(extract_connectator_params.merge(additional_params))
    end

    def connection_class
      case connectator_symbol
      when :db2              then Connectator::DB2::Connection
      when :mysql            then Connectator::MySQL::Connection
      when :oracle           then Connectator::Oracle::Connection
      when :sql, :sql_server then Connectator::SQL::Connection
      when :sybase           then Connectator::Sybase::Connection
      else                        raise "Connectator class was not found"
      end
    end

    def extract_connectator_params
      {
       :server   => rescue_as_nil { connectator_params.server   },
       :instance => rescue_as_nil { connectator_params.instance },
       :database => rescue_as_nil { connectator_params.database },
       :port     => rescue_as_nil { connectator_params.port     },
       :option   => rescue_as_nil { connectator_params.option   },
       :username => rescue_as_nil { connectator_params.username },
       :password => rescue_as_nil { connectator_params.password }
      }
    end

    private
    
    def connectator_symbol      
	    rescue_as_nil { connectator_params.kind.to_s.downcase.gsub(' ','_').intern }
    end

    def rescue_as_nil
      yield
    rescue
      nil
    end
  end
end

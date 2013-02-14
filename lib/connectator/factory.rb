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
      "Connectator::#{connectator_params.kind}::Connection".constantize
    end

    def extract_connectator_params
      {
       :server   => connectator_params.server,
       :instance => connectator_params.instance,
       :port     => connectator_params.port,
       :username => connectator_params.username,
       :password => connectator_params.password
      }
    end
  end
end

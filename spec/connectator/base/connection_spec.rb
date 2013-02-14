require 'spec_helper'

describe Connectator::Base::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::Sql::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::Base::Connection.new(:server    => 'Server',
                                        :port      => 'Port',
                                        :username  => 'User',
                                        :password  => 'Pass',
                                        :instance  => 'Instance')
    }                                    

    Then {
      connection_params = connection.connection_params
      connection_params.server.should    == 'Server'
      connection_params.port.should      == 'Port'
      connection_params.username.should  == 'User'
      connection_params.password.should  == 'Pass'
      connection_params.instance.should  == 'Instance'
    }

    Then { lambda { connection.connection_string }.should raise_error /Abstract Method/  }
    Then { lambda { connection.send :connection_params_hash }.should raise_error /Abstract Method/  }
  end
end

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
    
    Then { connection.connection_params.server.should       == 'Server'   }
    Then { connection.connection_params.port.should         == 'Port'     }
    Then { connection.connection_params.username.should     == 'User'     }
    Then { connection.connection_params.password.should     == 'Pass'     }
    Then { connection.connection_params.instance.should     == 'Instance' }

    Then { lambda { connection.connection_string }.should raise_error /Abstract Method/  }
    Then { lambda { connection.send :connection_params_hash }.should raise_error /Abstract Method/  }
  end

  describe "initalized with a valid server" do
    Given(:connection) {
      Connectator::Base::Connection.new(:server    => 'localhost')
    }                                    
    Then { connection.connection_params.server.should       == 'localhost' }
    Then { connection.ping?.should be_true }

    describe "initalized with a valid dbi connection" do
      Given { connection.stub(:valid_dbi?).and_return(true) }
      Then { connection.valid?.should be_true }
    end
  end
  
  describe "initalized with a valid dbi connection" do
    Given(:connection) {
      Connectator::Base::Connection.new(:server => 'localhost')
    }                                    
    Then { connection.connection_params.server.should       == 'localhost' }
    Then { connection.ping?.should be_true }
  end

end

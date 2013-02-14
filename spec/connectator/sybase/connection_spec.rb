require 'spec_helper'

describe Connectator::Sybase::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::Sybase::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::Sybase::Connection.new(:server    => 'Server',
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
    Then { connection.connection_params.tds_version.should  == '5.0'      }
    Then { connection.connection_params.database.should     == 'master'   }

    Then { connection.connection_string.should ==
          "DBI:ODBC:DRIVER=FreeTDS;TDS_Version=5.0;SERVER=Server;Port=Port;DATABASE=master;UID=User;PWD=Pass"  }

    Then { connection.send(:connection_params_hash).should == 
        {
         "DRIVER"      => 'FreeTDS',
         "TDS_Version" => '5.0',
         "SERVER"      => 'Server',
         "Port"        => 'Port',
         "DATABASE"    => 'master',
         "UID"         => 'User',
         "PWD"         => 'Pass'
        }
    }
  end
end

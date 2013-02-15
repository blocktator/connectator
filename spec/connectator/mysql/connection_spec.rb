require 'spec_helper'

describe Connectator::Mysql::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::Mysql::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::Mysql::Connection.new(:server    => 'Server',
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
    Then { connection.connection_params.database.should     == ''         }
    Then { connection.connection_params.option.should       == '3'        }

    Then { connection.connection_string.should ==
          "DBI:ODBC:DRIVER=MySQL;Server=Server;Port=Port;Database=;User=User;Password=Pass;Option=3"  }

    Then { connection.send(:connection_params_hash).should == 
      {
       "DRIVER"      => 'MySQL',
       "Server"      => 'Server',
       "Port"        => 'Port',
       "Database"    => '',
       "User"        => 'User',
       "Password"    => 'Pass',
       "Option"      => '3'
      }
    }
  end
end


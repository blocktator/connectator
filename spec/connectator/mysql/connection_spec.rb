require 'spec_helper'

describe Connectator::MySQL::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::MySQL::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::MySQL::Connection.new(:server    => 'Server',
                                         :username  => 'User',
                                         :password  => 'Pass',
					 :port      => '4040',
                                         :instance  => 'Instance',
					 :database  => 'meh',
					 :option    => '42')
    }                                    
    
    Then { connection.connection_params.server.should       == 'Server'   }
    Then { connection.connection_params.port.should         == '4040'     }
    Then { connection.connection_params.username.should     == 'User'     }
    Then { connection.connection_params.password.should     == 'Pass'     }
    Then { connection.connection_params.instance.should     == 'Instance' }
    Then { connection.connection_params.database.should     == 'meh'      }
    Then { connection.connection_params.option.should       == '42'       }

    Then { connection.connection_string.should ==
          "DBI:ODBC:DRIVER=MySQL;SERVER=Server;PORT=4040;DATABASE=meh;UID=User;PWD=Pass;OPTION=42"  }

    Then { connection.send(:connection_params_hash).should == 
      {
       "DRIVER"      => 'MySQL',
       "SERVER"      => 'Server',
       "PORT"        => '4040',
       "DATABASE"    => 'meh',
       "UID"         => 'User',
       "PWD"         => 'Pass',
       "OPTION"      => '42'
      }
    }
  end

  describe "initalized with missing optional params" do
    Given(:connection) {
      Connectator::MySQL::Connection.new(:server    => 'Server',
					 :username  => 'User',
					 :password  => 'Pass',
					 :instance  => 'Instance')
    }                                    
    
    Then { connection.connection_params.server.should       == 'Server'   }
    Then { connection.connection_params.port.should         == '3306'     }
    Then { connection.connection_params.username.should     == 'User'     }
    Then { connection.connection_params.password.should     == 'Pass'     }
    Then { connection.connection_params.instance.should     == 'Instance' }
    Then { connection.connection_params.database.should     == nil        }
    Then { connection.connection_params.option.should       == '3'        }

    Then { connection.connection_string.should ==
	  "DBI:ODBC:DRIVER=MySQL;SERVER=Server;PORT=3306;UID=User;PWD=Pass;OPTION=3"  }

    Then { connection.send(:connection_params_hash).should == 
      {
       "DRIVER"      => 'MySQL',
       "SERVER"      => 'Server',
       "PORT"        => '3306',
       "DATABASE"    => nil,
       "UID"         => 'User',
       "PWD"         => 'Pass',
       "OPTION"      => '3'
      }
    }
  end
end


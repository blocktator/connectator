require 'spec_helper'

describe Connectator::DB2::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::DB2::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::DB2::Connection.new(:server    => 'Server',
                                       :port      => 'Port',
                                       :username  => 'User',
                                       :password  => 'Pass',
                                       :instance  => 'Instance',
                                       :database  => 'ABCDEFG')
    }                                    
    
    Then { connection.connection_params.server.should       == 'Server'   }
    Then { connection.connection_params.port.should         == 'Port'     }
    Then { connection.connection_params.username.should     == 'User'     }
    Then { connection.connection_params.password.should     == 'Pass'     }
    Then { connection.connection_params.instance.should     == 'Instance' }
    Then { connection.connection_params.protocol.should     == 'TCPIP'    }
    Then { connection.connection_params.driver.should       == 'DB2'      }
    Then { connection.connection_params.database.should     == 'ABCDEFG'  }

    Then { connection.connection_string.should == 
           'DBI:ODBC:DRIVER=DB2;PROTOCOL=TCPIP;HOSTNAME=Server;PORT=Port;DATABASE=ABCDEFG;UID=User;PWD=Pass' }

    Then { connection.send(:connection_params_hash).should == 
      {
       "DRIVER"      => 'DB2',
       "PROTOCOL"    => 'TCPIP',
       "HOSTNAME"    => 'Server',
       "PORT"        => 'Port',
       "DATABASE"    => 'ABCDEFG',
       "UID"         => 'User',
       "PWD"         => 'Pass'
      }
    }
  end
end

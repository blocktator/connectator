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

    Then {
      connection_params = connection.connection_params
      connection_params.server.should       == 'Server'
      connection_params.port.should         == 'Port'
      connection_params.username.should     == 'User'
      connection_params.password.should     == 'Pass'
      connection_params.instance.should     == 'Instance'
      connection_params.protocol.should     == 'TCPIP'
      connection_params.driver.should       == 'DB2'
      connection_params.database.should     == 'ABCDEFG'
    }

    Then { connection.connection_string.should == 
           'DBI:ODBC:DRIVER=DB2;PROTOCOL=TCPIP;HOSTNAME=Server;Port=Port;DATABASE=ABCDEFG;UID=User;PWD=Pass' }
  end
end

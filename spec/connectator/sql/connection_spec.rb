require 'spec_helper'

describe Connectator::SQL::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::SQL::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::SQL::Connection.new(:server    => 'Server',
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
    Then { connection.connection_params.tds_version.should  == '8.0'      }
    Then { connection.connection_params.database.should     == 'master'   }

    Then { connection.connection_string.should ==
          "DBI:ODBC:DRIVER=FreeTDS;TDS_Version=8.0;SERVER=Server;PORT=Port;DATABASE=master;UID=User;PWD=Pass"  }

    Then { connection.send(:connection_params_hash).should == 
      {
       "DRIVER"      => 'FreeTDS',
       "TDS_Version" => '8.0',
       "SERVER"      => 'Server',
       "PORT"        => 'Port',
       "DATABASE"    => 'master',
       "UID"         => 'User',
       "PWD"         => 'Pass'
      }
    }
  end

  describe "with no instance" do
    Given(:connection) { Connectator::SQL::Connection.new(:server    => 'Server',
                                                          :instance  => nil) }                                    
    Then { connection.send(:server_instance_string).should == 'Server' }
  end

  describe "with an instance of format X\Y" do
    Given(:connection) { Connectator::SQL::Connection.new(:server    => 'Server',
                                                          :instance  => 'Host\Instance') }                                    
    Then { connection.send(:server_instance_string).should == 'Server\Instance' }
  end
  
  describe "with an instance of format X\Y$Z" do
    Given(:connection) { Connectator::SQL::Connection.new(:server    => 'Server',
                                                          :instance  => 'Host\Instance$Foo') }                                    
    Then { connection.send(:server_instance_string).should == 'Server\Instance$Foo' }
  end
  
  describe "with an instance of format X\Y_Z" do
    Given(:connection) { Connectator::SQL::Connection.new(:server    => 'Server',
                                                          :instance  => 'Host\Instance_Foo') }                                    
    Then { connection.send(:server_instance_string).should == 'Server\Instance_Foo' }
  end
end

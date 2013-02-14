require 'spec_helper'

describe Connectator::Sql::Connection do

  describe "initalized with no params" do
    Then { lambda { Connectator::Sql::Connection.new() }.should raise_error /Connection Options are required/  }
  end
  
  describe "initalized with basic params" do
    Given(:connection) {
      Connectator::Sql::Connection.new(:server    => 'Server',
                                       :port      => 'Port',
                                       :username  => 'User',
                                       :password  => 'Pass',
                                       :instance  => 'Instance')
    }                                    

    Then {
      connection_params = connection.connection_params
      connection_params.server.should       == 'Server'
      connection_params.port.should         == 'Port'
      connection_params.username.should     == 'User'
      connection_params.password.should     == 'Pass'
      connection_params.instance.should     == 'Instance'
      connection_params.tds_version.should  == '8.0'
      connection_params.database.should     == 'master'
    }

    Then { connection.connection_string.should ==
          "DBI:ODBC:DRIVER=FreeTDS;TDS_Version=8.0;SERVER=Server;Port=Port;DATABASE=master;UID=User;PWD=Pass"  }
    Then { connection.send(:connection_params_hash).should == 
        {
         "DRIVER"      => 'FreeTDS',
         "TDS_Version" => '8.0',
         "SERVER"      => 'Server',
         "Port"        => 'Port',
         "DATABASE"    => 'master',
         "UID"         => 'User',
         "PWD"         => 'Pass'
        }
    }
  end

  describe "with no instance" do
    Given(:connection) { Connectator::Sql::Connection.new(:server    => 'Server',
                                                          :instance  => nil) }                                    
    Then { connection.send(:server_instance_string).should == 'Server' }
  end

  describe "with an instance of format X\Y" do
    Given(:connection) { Connectator::Sql::Connection.new(:server    => 'Server',
                                                          :instance  => 'Host\Instance') }                                    
    Then { connection.send(:server_instance_string).should == 'Server\Instance' }
  end
  
  describe "with an instance of format X\Y$Z" do
    Given(:connection) { Connectator::Sql::Connection.new(:server    => 'Server',
                                                          :instance  => 'Host\Instance$Foo') }                                    
    Then { connection.send(:server_instance_string).should == 'Server\Instance$Foo' }
  end
  
  describe "with an instance of format X\Y_Z" do
    Given(:connection) { Connectator::Sql::Connection.new(:server    => 'Server',
                                                          :instance  => 'Host\Instance_Foo') }                                    
    Then { connection.send(:server_instance_string).should == 'Server\Instance_Foo' }
  end
end

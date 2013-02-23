require 'spec_helper'

describe Connectator::Factory do

  describe "a params object with an undefined kind" do
    Given(:connection_params_object) { Object.new }
    When(:factory) { Connectator::Factory.new(connection_params_object) }
    Then { lambda { factory.connection_class }.should raise_error /not found/ }
  end
 
  describe "DB2" do 
    Given(:connection_params_object) { OpenStruct.new(:kind => kind) }
    When(:factory) { Connectator::Factory.new(connection_params_object) }

    describe "'DB2'" do
      Given(:kind) { 'DB2' }
      Then { factory.connection_class.should == Connectator::DB2::Connection }
    end
    
    describe "'db2'" do
      Given(:kind) { 'db2' }
      Then { factory.connection_class.should == Connectator::DB2::Connection }
    end
    
    describe ":db2" do
      Given(:kind) { :db2 }
      Then { factory.connection_class.should == Connectator::DB2::Connection }
    end
  end
  
  describe "MySQL" do 
    Given(:connection_params_object) { OpenStruct.new(:kind => kind) }
    When(:factory) { Connectator::Factory.new(connection_params_object) }

    describe "'MySQL'" do
      Given(:kind) { 'MySQL' }
      Then { factory.connection_class.should == Connectator::MySQL::Connection }
    end
    
    describe "'mysql'" do
      Given(:kind) { 'mysql' }
      Then { factory.connection_class.should == Connectator::MySQL::Connection }
    end
    
    describe ":mysql" do
      Given(:kind) { :mysql }
      Then { factory.connection_class.should == Connectator::MySQL::Connection }
    end
  end
  
  describe "Oracle" do 
    Given(:connection_params_object) { OpenStruct.new(:kind => kind) }
    When(:factory) { Connectator::Factory.new(connection_params_object) }

    describe "'Oracle'" do
      Given(:kind) { 'Oracle' }
      Then { factory.connection_class.should == Connectator::Oracle::Connection }
    end
    
    describe "'oracle'" do
      Given(:kind) { 'oracle' }
      Then { factory.connection_class.should == Connectator::Oracle::Connection }
    end
    
    describe ":oracle" do
      Given(:kind) { :oracle }
      Then { factory.connection_class.should == Connectator::Oracle::Connection }
    end
  end

  describe "SQL Server" do 
    Given(:connection_params_object) { OpenStruct.new(:kind => kind) }
    When(:factory) { Connectator::Factory.new(connection_params_object) }

    describe "'SQL'" do
      Given(:kind) { 'SQL' }
      Then { factory.connection_class.should == Connectator::SQL::Connection }
    end
    
    describe "'SQL Server'" do
      Given(:kind) { 'SQL Server' }
      Then { factory.connection_class.should == Connectator::SQL::Connection }
    end
    
    describe "'Sql'" do
      Given(:kind) { 'Sql' }
      Then { factory.connection_class.should == Connectator::SQL::Connection }
    end
    
    describe "'sql'" do
      Given(:kind) { 'sql' }
      Then { factory.connection_class.should == Connectator::SQL::Connection }
    end
    
    describe ":sql" do
      Given(:kind) { :sql }
      Then { factory.connection_class.should == Connectator::SQL::Connection }
    end
    
    describe ":sql_server" do
      Given(:kind) { :sql_server }
      Then { factory.connection_class.should == Connectator::SQL::Connection }
    end
  end

  describe "Sybase" do 
    Given(:connection_params_object) { OpenStruct.new(:kind => kind) }
    When(:factory) { Connectator::Factory.new(connection_params_object) }

    describe "'Sybase'" do
      Given(:kind) { 'Sybase' }
      Then { factory.connection_class.should == Connectator::Sybase::Connection }
    end
    
    describe "'sybase'" do
      Given(:kind) { 'sybase' }
      Then { factory.connection_class.should == Connectator::Sybase::Connection }
    end
    
    describe ":sybase" do
      Given(:kind) { :sybase }
      Then { factory.connection_class.should == Connectator::Sybase::Connection }
    end
  end
end

# Connectator [![Build Status](https://travis-ci.org/jamin4jc/connectator.png?branch=master)](https://travis-ci.org/jamin4jc/connectator)
 
Multi-System Connection Proxy Mutator

## Setup/Installation

* Connect to any system (at least theoretically).  This gem is a multi-system
connection proxy.  Right now the gem only supports database connections through
a fork of the ruby-dbi gem by Erik Hollensbe called connectator-dbi.  This gem
is only intended to be used on UNIX/Linux type systems.

In addition to the gem, your system needs to have unixODBC for most of the
database connections except for Oracle.  FreeTDS is required for SQL Server
and Sybase.  If you want to use MySQL, you will need to set up the MySQL ODBC
client.  The same goes for DB2

### System Software

#### unixODBC (http://www.unixodbc.org)

    sudo apt-get install unixodbc

After installing unixODBC, you will need to set up your unixodbc.ini.  This
gem expects that to use DSN-less (unnamed) configurations for systems as
opposed to specifying each system in your unixodbc.ini.  There is an
example_odbcinst.ini in this project.  Some of the syntax is very important.
For instance the names of each section needs to be exactly as specified,
but the location of the Driver and Setup files should match your system.
Other settings are per your discretion.

This file is generally located on your system at /etc/odbcinst.ini.

#### FreeTDS (http://freetds.schemamania.org)

FreeTDS is used as the driver for the SQL Server and Sybase Connectator.

Install the FreeTDS package if you want to use SQL Server or Syabase.
On Ubuntu this would equate to:

    sudo apt-get install freetds

#### MySQL Client for ODBC

Install the MySQL client for ODBC if you want to use the MySQL Connectator.
On Ubuntu this would equate to:

    sudo apt-get install libmyodbc

#### Oracle Client

Install an Oracle Client if you want to use the Oracle Connectator

To use the Oracle Connectator you will need to install some kind of Oracle
client, either the instant client or full client. There are plenty of
instructions online for setting this up, so I will not elaborate here.

#### DB2 Client

Install the DB2 client if you want to use the DB2 Connectator

### Gem Installation

    gem install connectator
    gem install ruby-oci8   # optionally if you want to use Oracle

## Connectator Systems

### Oracle

* Uses the ruby-oci8 gem directly.  Note that this gem does not directly
require the ruby-oci8 gem.  If you need to use Oracle you should include the
ruby-oci8 gem in your project.

### Sql Server/Sybase

* Uses DBI:ODBC
* In order to use SQL Server/Sybase with Connectator, you will need to set up
Unix ODBC and FreeTDS.  Unix ODBC will need to reference FreeTDS as one of its
drivers.

### MySQL

* Uses DBI:ODBC
* In order to use MySQL with Connectator, you will need to set up Unix ODBC and
the MySQL client. Unix ODBC will need to reference the MySQL driver as one of
its drivers.
* On Ubuntu, use package: libmyodbc

### DB2

* Uses DBI:DB2
* In order to use DB2 with Connectator, you will need to set up Unix ODBC and
the DB2 client. Unix ODBC will need to reference the DB2 driver as one of its
drivers.

## Usage
    
    # Initiate the connection object
    c = Connectator::MySQL::Connection.new(:server   => 'server.com',
                                           :database => 'foo',
                                           :port     => '3306',
                                           :username => 'my_user', 
                                           :password => 'secret')
    # Check to see if this is a valid connection
    c.valid?
    # if there was an error, you can inspect
    c.error
    # run a select statement against the database
    c.select_all('select * from foo.bar')

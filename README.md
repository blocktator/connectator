# connectator

Multi-Connection proxy for DBI

## Notes

*This gem is currently using the older DBI gem.*
https://github.com/erikh/ruby-dbi

This will at some point in the future change to use the new rdbi gem.
https://github.com/RDBI/rdbi

### Oracle

* Uses the ruby-oci8 gem directly
* Note that this gem does not directly require the ruby-oci8 gem.  If you need
to use Oracle, include the ruby-oci8 gem in your project.

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

### DB2

* Uses DBI:DB2
* In order to use DB2 with Connectator, you will need to set up Unix ODBC and
the DB2 client. Unix ODBC will need to reference the DB2 driver as one of its
drivers.

## UNIX ODBC

See example_odbcinst.ini for a sample of what the /etc/odbcinst.ini should look like.

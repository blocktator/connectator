module Connectator
  module Base
    class DBIProxy

      def initialize(connection)
        @connection = connection
      end

      def connection
        @connection
      end

      def close
        connection.disconnect
      end

      # Do not use this method on queries that return lots of data
      # because it would use a lot of memory.
      def select_all_to_hash(query)
        result = []
        sth = connection.execute(query)
        sth.fetch_hash do |row|
          result << row
        end
        result
      end

      def method_missing(method, *args, &blk)
        connection.send(method, *args, &blk)
      end
    end
  end
end

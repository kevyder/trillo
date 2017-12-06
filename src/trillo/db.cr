require "db"

require "sqlite3"

module Trillo::DB

  @@database : ::DB::Database?

  def self.db

    @@database ||= ::DB.open "sqlite3://./data.db"

  end

end

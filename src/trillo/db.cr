require "db"
require "pg"

module Trillo::DB
  @@database : ::DB::Database?
  def self.db
    @@database ||= ::DB.open "postgres://postgres:postgres@localhost:5432/trillo"
  end
end

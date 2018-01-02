require "granite_orm/adapter/pg"

class Board < Granite::ORM::Base
  adapter pg
  primary id : Int32
  field name : String
  timestamps
end

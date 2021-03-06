require "granite_orm/adapter/pg"

class Board < Granite::ORM::Base
  adapter pg
  has_many :lists
  primary id : Int32
  field name : String
  timestamps
end

require "granite_orm/adapter/pg"

class List < Granite::ORM::Base
  adapter pg
  belongs_to :board
  primary id : Int32
  field name : String
  field sort : Int32
  timestamps
end

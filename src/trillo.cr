require "./trillo/*"
require "./models/*"
require "kemal"

get "/" do |env|
  boards = Trillo::DB.db.query_all("SELECT id, name FROM boards", as: Board)
  boards.to_json
end

post "/" do |env|
  name = env.params.query["name"].to_s.as(String)
  Trillo::DB.db.query_all("INSERT INTO boards (name) values ('#{name}')", as: Board)
end

at_exit { Trillo::DB.db.close }

Kemal.run

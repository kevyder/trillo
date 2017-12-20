require "./trillo/*"
require "./models/*"
require "kemal"

get "/boards" do |env|
  boards = Trillo::DB.db.query_all("SELECT id, name FROM boards", as: Board)
  boards.to_json
end

get "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  board = Trillo::DB.db.query_all("SELECT id, name FROM boards WHERE id = #{id}", as: Board)
  board.to_json
end

post "/boards" do |env|
  name = env.params.query["name"].to_s.as(String)
  Trillo::DB.db.query_all("INSERT INTO boards (name) values ('#{name}')", as: Board)
  board = Trillo::DB.db.query_all("SELECT id, name FROM boards ORDER BY id DESC LIMIT 1", as: Board)
  board.to_json
end

put "/boards/:id" do |env|
  name = env.params.query["name"].to_s.as(String)
  id = env.params.url["id"].to_i
  Trillo::DB.db.query_all("UPDATE boards SET name = '#{name}' WHERE id = #{id}", as: Board)
  board = Trillo::DB.db.query_all("SELECT id, name FROM boards WHERE id = #{id}", as: Board)
  board.to_json
end

delete "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  Trillo::DB.db.query_all("DELETE FROM boards WHERE id = #{id}", as: Board)
  {"message" => "Board has been deleted"}.to_json
end

at_exit { Trillo::DB.db.close }

Kemal.run

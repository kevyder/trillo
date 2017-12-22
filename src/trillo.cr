require "./trillo/*"
require "./models/*"
require "kemal"

# Boards
get "/boards" do |env|
  boards = Trillo::DB.db.query_all("SELECT id, name FROM boards", as: Board)
  env.response.content_type = "application/json"
  boards.to_json
end

get "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  board = Trillo::DB.db.query_all("SELECT id, name FROM boards WHERE id = #{id}", as: Board)
  env.response.content_type = "application/json"
  board.to_json
end

post "/boards" do |env|
  name = env.params.query["name"].to_s.as(String)
  Trillo::DB.db.query_all("INSERT INTO boards (name) values ('#{name}')", as: Board)
  board = Trillo::DB.db.query_all("SELECT id, name FROM boards ORDER BY id DESC LIMIT 1", as: Board)
  env.response.content_type = "application/json"
  board.to_json
end

put "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  name = env.params.query["name"].to_s.as(String)
  Trillo::DB.db.query_all("UPDATE boards SET name = '#{name}' WHERE id = #{id}", as: Board)
  board = Trillo::DB.db.query_all("SELECT id, name FROM boards WHERE id = #{id}", as: Board)
  env.response.content_type = "application/json"
  board.to_json
end

delete "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  Trillo::DB.db.query_all("DELETE FROM boards WHERE id = #{id}", as: Board)
  env.response.content_type = "application/json"
  {"message" => "Board has been deleted"}.to_json
end

# Lists
get "/lists" do |env|
  lists = Trillo::DB.db.query_all("SELECT id, name, sort, board_id FROM lists", as: List)
  env.response.content_type = "application/json"
  lists.to_json
end

get "/lists/:id" do |env|
  id = env.params.url["id"].to_i
  list = Trillo::DB.db.query_all("SELECT id, name, sort, board_id FROM lists where id = #{id}", as: List)
  env.response.content_type = "application/json"
  list.to_json
end

post "/lists" do |env|
  name = env.params.query["name"].to_s.as(String)
  sort = env.params.query["sort"].to_i
  board_id = env.params.query["board_id"].to_i
  Trillo::DB.db.query_all("INSERT INTO lists (name, sort, board_id) values ('#{name}', #{sort}, #{board_id})", as: List)
  list = Trillo::DB.db.query_all("SELECT id, name, sort, board_id FROM lists ORDER BY id DESC LIMIT 1", as: List)
  env.response.content_type = "application/json"
  list.to_json
end

put "/lists/:id" do |env|
  id = env.params.url["id"].to_i
  name = env.params.query["name"].to_s.as(String)
  sort = env.params.query["sort"].to_i
  board_id = env.params.query["board_id"].to_i
  Trillo::DB.db.query_all("UPDATE lists SET name = '#{name}', sort = #{sort}, board_id = #{board_id} WHERE id = #{id}", as: List)
  list = Trillo::DB.db.query_all("SELECT id, name, sort, board_id FROM lists WHERE ID = #{id}", as: List)
  env.response.content_type = "application/json"
  list.to_json
end

delete "/lists/:id" do |env|
  id = env.params.url["id"].to_i
  Trillo::DB.db.query_all("DELETE FROM lists WHERE id = #{id}", as: List)
  env.response.content_type = "application/json"
  {"message" => "List has been deleted"}.to_json
end


at_exit { Trillo::DB.db.close }

Kemal.run

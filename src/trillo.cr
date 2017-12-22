require "./trillo/*"
require "./models/*"
require "kemal"

db = Database.new
# Boards
get "/boards" do |env|
  boards = db.query("SELECT id, name FROM boards", Board)
  env.response.content_type = "application/json"
  boards.to_json
end

get "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  board = db.query("SELECT id, name FROM boards WHERE id = #{id}", Board)
  env.response.content_type = "application/json"
  board.to_json
end

post "/boards" do |env|
  name = env.params.query["name"].to_s.as(String)
  db.query("INSERT INTO boards (name) values ('#{name}')", Board)
  board = db.query("SELECT id, name FROM boards ORDER BY id DESC LIMIT 1", Board)
  env.response.content_type = "application/json"
  board.to_json
end

put "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  name = env.params.query["name"].to_s.as(String)
  db.query("UPDATE boards SET name = '#{name}' WHERE id = #{id}", Board)
  board = db.query("SELECT id, name FROM boards WHERE id = #{id}", Board)
  env.response.content_type = "application/json"
  board.to_json
end

delete "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  db.query("DELETE FROM boards WHERE id = #{id}", Board)
  env.response.content_type = "application/json"
  { "message" => "Board has been deleted" }.to_json
end

# Lists
get "/lists" do |env|
  lists = db.query("SELECT id, name, sort, board_id FROM lists", List)
  env.response.content_type = "application/json"
  lists.to_json
end

get "/lists/:id" do |env|
  id = env.params.url["id"].to_i
  list = db.query("SELECT id, name, sort, board_id FROM lists where id = #{id}", List)
  env.response.content_type = "application/json"
  list.to_json
end

post "/lists" do |env|
  name = env.params.query["name"].to_s.as(String)
  sort = env.params.query["sort"].to_i
  board_id = env.params.query["board_id"].to_i
  db.query("INSERT INTO lists (name, sort, board_id) values ('#{name}', #{sort}, #{board_id})", List)
  list = db.query("SELECT id, name, sort, board_id FROM lists ORDER BY id DESC LIMIT 1", List)
  env.response.content_type = "application/json"
  list.to_json
end

put "/lists/:id" do |env|
  id = env.params.url["id"].to_i
  name = env.params.query["name"].to_s.as(String)
  sort = env.params.query["sort"].to_i
  board_id = env.params.query["board_id"].to_i
  db.query("UPDATE lists SET name = '#{name}', sort = #{sort}, board_id = #{board_id} WHERE id = #{id}", List)
  list = db.query("SELECT id, name, sort, board_id FROM lists WHERE ID = #{id}", List)
  env.response.content_type = "application/json"
  list.to_json
end

delete "/lists/:id" do |env|
  id = env.params.url["id"].to_i
  db.query("DELETE FROM lists WHERE id = #{id}", List)
  env.response.content_type = "application/json"
  {"message" => "List has been deleted"}.to_json
end

db.close

Kemal.run

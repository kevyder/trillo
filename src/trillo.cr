require "db"
require "./trillo/version"
require "./models/*"
require "kemal"

# Boards
get "/boards" do |env|
  boards = Board.all
  env.response.content_type = "application/json"
  boards.to_json
end

get "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  board = Board.find(id)
  env.response.content_type = "application/json"
  board.to_json
end

post "/boards" do |env|
  name = env.params.query["name"].to_s.as(String)
  board = Board.new
  board.name = name
  board.save
  env.response.content_type = "application/json"
  board.to_json
end

put "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  # name = env.params.query["name"].to_s.as(String)
  board = Board.find_by(:id, id)
  # board.name
  env.response.content_type = "application/json"
  board.to_json
end

delete "/boards/:id" do |env|
  id = env.params.url["id"].to_i
  board = Board.find(id)
  env.response.content_type = "application/json"
  { "message" => "Board has been deleted" }.to_json
end

# Lists
get "/lists" do |env|
  board_id = nil

  if env.params.query.includes? "board_id"
    board_id = env.params.query["board_id"].to_i
  end

  if board_id
    lists = List.all("WHERE id = #{board_id}")
  else
    lists = List.all
  end

  env.response.content_type = "application/json"
  lists.to_json
end
#
# get "/lists/:id" do |env|
#   id = env.params.url["id"].to_i
#   list = db.query("SELECT id, name, sort, board_id FROM lists where id = #{id}", List)
#   env.response.content_type = "application/json"
#   list.to_json
# end
#
# post "/lists" do |env|
#   name = env.params.query["name"].to_s.as(String)
#   sort = env.params.query["sort"].to_i
#   board_id = env.params.query["board_id"].to_i
#   db.query("INSERT INTO lists (name, sort, board_id) values ('#{name}', #{sort}, #{board_id})", List)
#   list = db.query("SELECT id, name, sort, board_id FROM lists ORDER BY id DESC LIMIT 1", List)
#   env.response.content_type = "application/json"
#   list.to_json
# end
#
# put "/lists/:id" do |env|
#   id = env.params.url["id"].to_i
#   name = env.params.query["name"].to_s.as(String)
#   sort = env.params.query["sort"].to_i
#   board_id = env.params.query["board_id"].to_i
#   db.query("UPDATE lists SET name = '#{name}', sort = #{sort}, board_id = #{board_id} WHERE id = #{id}", List)
#   list = db.query("SELECT id, name, sort, board_id FROM lists WHERE ID = #{id}", List)
#   env.response.content_type = "application/json"
#   list.to_json
# end
#
# delete "/lists/:id" do |env|
#   id = env.params.url["id"].to_i
#   db.query("DELETE FROM lists WHERE id = #{id}", List)
#   env.response.content_type = "application/json"
#   {"message" => "List has been deleted"}.to_json
# end
#
# db.close

Kemal.run

require "./trillo/*"
require "kemal"

get "/" do |env|
  Trillo::DB.db.query("SELECT id, name FROM boards") do |rs|
    rs.each do
      env.response.puts("#{rs.read(Int32)} (#{rs.read(String)})")
    end
  end
end

post "/" do |env|
  env.response.content_type = "application/json"
  name = env.params.query["name"].to_s.as(String)
  Trillo::DB.db.exec("INSERT INTO boards (name) values ('#{name}')")
  {name: name}.to_json
end

at_exit { Trillo::DB.db.close }

Kemal.run

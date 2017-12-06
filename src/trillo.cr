require "./trillo/*"
require "kemal"

get "/" do |env|
  Trillo::DB.db.query("SELECT name, age FROM contacts") do |rs|
    rs.each do
      env.response.puts("#{rs.read(String)} (#{rs.read(Int32)})")
    end
  end
end

post "/" do |env|
  env.response.content_type = "application/json"
  name = env.params.query["name"].as(String)
  age = env.params.query["age"].to_i.as(Int32)
  Trillo::DB.db.exec("INSERT INTO contacts (name, age) VALUES (?, ?)", name, age)
  {name: name, age: age}.to_json
end

at_exit { Trillo::DB.db.close }

Kemal.run

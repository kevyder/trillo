class Database

  def initialize
  end

  def query(query, model)
    Trillo::DB.db.query_all(query, as: model)
  end

  def close
    at_exit { Trillo::DB.db.close }
  end
end

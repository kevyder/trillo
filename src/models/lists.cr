class List
  ::DB.mapping({
    id: Int32,
    name: String,
    sort: Int32,
    board_id: Int32
  })

  JSON.mapping({
    id: Int32,
    name: String,
    sort: Int32,
    board_id: Int32
  })
end

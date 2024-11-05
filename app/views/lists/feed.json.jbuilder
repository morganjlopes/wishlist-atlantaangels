json.array! @lists do |list|
  json.id              list.id
  json.name            list.name
  json.alias           list.alias
  json.age             list.age
  json.gender          list.gender
  json.gift_card_store list.gift_card_store
  json.created_at      list.created_at
  
  json.family do
    json.name list.family.name
  end

  json.list_items list.list_items do |list_item|
    json.name        list_item.name
    json.description list_item.description
    json.url         list_item.url
  end
end

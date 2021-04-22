Thing = {}


--- Returns item name by given item id.
-- Returns item name based on market data - might not work for clients that lack of market data in .dat.
-- @return string items name
function Thing.GetItemNameById(itemId)
    return Item.create(itemId):getMarketData().name
end

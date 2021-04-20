Self = {}


--- Uses back inventory slot once.
-- It doesn't return backpack due to
-- @return void
function Self.UseMainBackpack()
    g_game.use(g_game.getLocalPlayer():getInventoryItem(InventorySlotBack))
end

--- Returns back inventory slot item id.
-- @return number id
function Self.GetMainBackpackId()
    return g_game.getLocalPlayer():getInventoryItem(InventorySlotBack):getId()
end

--- Turns character in the given direction.
-- @return void
function Self.Turn(direction)
    return turn(direction)
end

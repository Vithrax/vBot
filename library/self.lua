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

--- Uses purse inventory slot once.
-- @return void
function Self.OpenPurse()
    return g_game.use(g_game.getLocalPlayer():getInventoryItem(InventorySlotPurse))
end

--- Turns character in the given direction.
-- @return void
function Self.Turn(direction)
    return turn(direction)
end

--- Reopens purse.
-- Used mainly for gunzodus/ezodus
-- @author Vithrax
-- @return void
function Self.ReopenPurse()
    for _, container in pairs(Container.GetOpenedContainers()) do
        if container:getName():lower() == "loot bag" or container:getName():lower() == "store inbox" then
            g_game.close(container:getNativeContainer())
        end
    end
    schedule(300, function() Self.OpenPurse() end)
    schedule(1400, function()
        for _, container in pairs(Container.GetOpenedContainers()) do
            if container:getName():lower() == "store inbox" then
                for _, item in pairs(container:getItems()) do
                    if item:getId() == 23721 then
                        g_game.open(item, container:getNativeContainer())
                    end
                end
            end
        end
    end)

    return CaveBot.delay(1500)
end
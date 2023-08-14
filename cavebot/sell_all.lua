CaveBot.Extensions.SellAll = {}

local sellAllCap = 0
CaveBot.Extensions.SellAll.setup = function()
  CaveBot.registerAction("SellAll", "#C300FF", function(value, retries)
    local val = string.split(value, ",")
    local npc_name = val[1]:trim()
    local npc = getCreatureByName(npc_name)
    local exceptions = {}

    if retries > 10 then
      print("CaveBot[SellAll]: Can't sell, skipping")
      return false
    end

    if not npc then
      print("CaveBot[SellAll]: NPC not found! skipping")
      return false
    end

    if freecap() == sellAllCap then
      sellAllCap = 0
      print("CaveBot[SellAll]: Sold everything, proceeding")
      return true
    end

    delay(storage.extras.talkDelay)

    if not CaveBot.ReachNPC(npcName) then
      return "retry"
    end

    if not NPC.isTrading() then
      CaveBot.OpenNpcTrade()
      delay(2 * storage.extras.talkDelay)
      return "retry"
    else
      sellAllCap = freecap()
    end

    for i, v in ipairs(val) do
      v = v:trim()
      v = tonumber(v) or v
      table.insert(exceptions, v)
    end

    storage.cavebotSell = storage.cavebotSell or {}
    for i, item in ipairs(storage.cavebotSell) do
      local data = type(item) == 'number' and item or item.id
      if not table.find(exceptions, data) then
        table.insert(exceptions, data)
      end
    end

    table.dump(exceptions)

    modules.game_npctrade.sellAll(storage.extras.talkDelay, exceptions)
    print("CaveBot[SellAll]: Sold All items")

    return "retry"
  end)

 CaveBot.Editor.registerAction("sellall", "sell all", {
  value="NPC",
  title="Sell All",
  description="NPC Name, exceptions: id separated by comma",
 })
end

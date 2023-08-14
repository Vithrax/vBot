CaveBot.Extensions.BuySupplies = {}

CaveBot.Extensions.BuySupplies.setup = function()
  CaveBot.registerAction("BuySupplies", "#C300FF", function(value, retries)
    local possible_items = {}
    local npc_name = string.split(value, ",")[1]:trim()
    local npc = getCreatureByName(npc_name)

    if retries > 50 then
      print("CaveBot[BuySupplies]: Too many tries, can't buy")
      return false
    end

    if not npc then
      print("CaveBot[BuySupplies]: NPC not found")
      return false
    end

    if not CaveBot.ReachNPC(npc_name) then
      return "retry"
    end

    if not NPC.isTrading() then
      CaveBot.OpenNpcTrade()
      CaveBot.delay(2 * storage.extras.talkDelay)
      return "retry"
    end

    local npc_items = NPC.getBuyItems()
    for i, v in pairs(npc_items) do
      table.insert(possible_items, v.id)
    end

    local transaction_delay = 1

    for id, values in pairs(Supplies.getItemsData()) do
      id = tonumber(id)
      if table.find(possible_items, id) then
        local items_max = values.max
        local items_current = player:getItemsCount(id)
        local items_to_buy = items_max - items_current
        local transaction_loops = math.ceil(items_to_buy / 100)

        for i = 1, transaction_loops, 1 do
          if (i < transaction_loops) then
            items_to_buy = items_to_buy - 100
            schedule(
              (i * 2 * storage.extras.talkDelay),
              function()
                NPC.buy(id, 100)
                print("CaveBot[BuySupplies]: bought 100x " .. id)
              end
            )
          else
            schedule(
              (i * 2 * storage.extras.talkDelay),
              function()
                NPC.buy(id, items_to_buy)
                print("CaveBot[BuySupplies]: bought " .. items_to_buy .. "x " .. id)
              end
            )
          end
        end

        transaction_delay = transaction_delay + transaction_loops
      end
    end

    CaveBot.delay(transaction_delay * 2 * storage.extras.talkDelay)
    print("CaveBot[BuySupplies]: bought everything, proceeding")
    return true
 end)

 CaveBot.Editor.registerAction("buysupplies", "buy supplies", {
  value="NPC name",
  title="Buy Supplies",
  description="NPC Name",
 })
end

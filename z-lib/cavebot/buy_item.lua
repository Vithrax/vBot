CaveBot.Extensions.BuyItem = {}

CaveBot.Extensions.BuyItem.setup = function()
  CaveBot.registerAction("BuyItem", "#ffffff", function(value)
    local data = string.split(value, ",")
    local npc_name = data[1]:trim()
    local item_id = tonumber(data[2]:trim())
    local item_amount = tonumber(data[3]:trim())

    if not CaveBot.ReachNPC(npc_name) then
      return "retry"
    end

    if not NPC.isTrading() then
      CaveBot.OpenNpcTrade()
      CaveBot.delay(storage.extras.talkDelay*2)
      return "retry"
    end

    local item_amount_buy = item_amount - itemAmount(item_id)
    NPC.buy(item_id, item_amount_buy)

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
    return true
  end)

  CaveBot.Editor.registerAction("buyitem", "buy item", {
    value="npc_name, item_id, item_amount",
    title="Buy item",
    description="Buy item on NPC (npc_name, item_id, item_amount)",
    multiline=false
  })
end

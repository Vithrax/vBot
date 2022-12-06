CaveBot.Extensions.BuyItem = {}

CaveBot.Extensions.BuyItem.setup = function()
	CaveBot.registerAction("BuyItem", "#ffffff", function(value)
		local data = string.split(value, ",")
		local npcName = data[1]:trim()
		local itemId = tonumber(data[2]:trim())
		local itemAmountToHave = tonumber(data[3]:trim())
		local defaultDelay = 750

		if not CaveBot.ReachNPC(npcName) then
			return "retry"
		end

		if not NPC.isTrading() then
      CaveBot.OpenNpcTrade()
      CaveBot.delay(storage.extras.talkDelay*2)
      return "retry"
    end

		local itemAmountBuy = itemAmountToHave - itemAmount(itemId)
		NPC.buy(itemId, itemAmountBuy)

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("buyitem", "buy item", {
		value="npcName, itemId, amount",
		title="Buy item",
		description="Buy item on NPC (npcName, itemId, amount)",
		multiline=false
	})
end

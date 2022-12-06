CaveBot.Extensions.CheckItem = {}

CaveBot.Extensions.CheckItem.setup = function()
	CaveBot.registerAction("CheckItem", "#ffffff", function(value)
		local data = string.split(value, ",")
		local labelToGo = data[1]:trim()
		local itemId = tonumber(data[2]:trim())
		local itemAmountCheck = tonumber(data[3]:trim())

		if itemAmount(itemId) < itemAmountCheck then
			CaveBot.gotoLabel(labelToGo)
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("checkitem", "check item", {
		value="label, itemId, amount",
		title="Check item",
		description="Check item on container (label if item not found, itemId, amount)",
		multiline=false
	})
end

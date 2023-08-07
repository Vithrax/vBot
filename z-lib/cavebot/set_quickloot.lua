CaveBot.Extensions.SetQuickloot = {}

CaveBot.Extensions.SetQuickloot.setup = function()
	CaveBot.registerAction("SetQuickloot", "#ffffff", function(value)
		local itemList = string.split(value, ",")
		local defaultDelay = 5000

		if StorageConfig.lastQuickloot == value then
			return true
		end

		StorageCfg.setData('lastQuickloot', "")

		NPC.say("!quickloot clear")
		for index, item in pairs(itemList) do
			schedule(
				(index * defaultDelay),
				function()
					local itemTrim = item:trim()
					NPC.say("!quickloot add," .. itemTrim)
				end
			)
		end
		StorageCfg.setData('lastQuickloot', value)

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + ((tableLength(itemList) + 2) * defaultDelay))
		return true
	end)

	CaveBot.Editor.registerAction("setquickloot", "set quickloot", {
		value="item1, item2, item3",
		title="Set Quickloot",
		description="Set items for be taken in Quickloot",
		multiline=false
	})
end

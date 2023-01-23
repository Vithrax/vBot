CaveBot.Extensions.SimpleCheck = {}

CaveBot.Extensions.SimpleCheck.setup = function()
	CaveBot.registerAction("SimpleCheck", "#ffffff", function(value)
		local supplyData = Supplies.hasEnough()
		local supplyInfo = Supplies.getAdditionalData()

		local hasToRefill = storage.caveBot.forceRefill or storage.caveBot.backStop or storage.caveBot.backTrainers or storage.caveBot.backOffline or (supplyInfo.stamina.enabled and stamina() < tonumber(supplyInfo.stamina.value)) or type(supplyData) == "table"

		if not hasToRefill then
			CaveBot.gotoLabel(value)
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("simplecheck", "simple check", {
		value="starthunt",
		title="Simple check",
		description="Simple supply check",
		multiline=false
	})
end

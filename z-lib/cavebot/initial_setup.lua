CaveBot.Extensions.InitialSetup = {}

CaveBot.Extensions.InitialSetup.setup = function()
	CaveBot.registerAction("InitialSetup", "#ffffff", function(value)
		local cavebotBlessings = StorageConfig.cavebotBlessings or "-Blessings-Walk"

		TargetBot.setCurrentProfile(CaveBot.getCurrentProfile())
		if player:getName() == "Junkhead" then
			TargetBot.setCurrentProfile(CaveBot.getCurrentProfile() .. "-Ninja")
		end
		TargetBot.setOn()

		if player:getBlessings() == 0 and CaveBot.getCurrentProfile() ~= cavebotBlessings then
			TargetBot.setCurrentProfile(cavebotBlessings)
			CaveBot.setCurrentProfile(cavebotBlessings)
			return true
		end

		if CaveBot.getCurrentProfile() == cavebotBlessings then
			return true
		end

		local supplyData = Supplies.hasEnough()
		local supplyInfo = Supplies.getAdditionalData()

		local hasToRefill = storage.caveBot.forceRefill or storage.caveBot.backStop or storage.caveBot.backTrainers or storage.caveBot.backOffline or (supplyInfo.stamina.enabled and stamina() < tonumber(supplyInfo.stamina.value)) or type(supplyData) == "table"

		local isCaveBotRefill = CaveBot.getCurrentProfile() == "-Refill" or CaveBot.getCurrentProfile() == "-LootSeller"

		if hasToRefill and not isCaveBotRefill then
			TargetBot.setCurrentProfile("-Refill")
			CaveBot.setCurrentProfile("-Refill")
			return true
		end

		local citiesLootSeller = string.split(value, ",")

		if not isCaveBotRefill and citiesLootSeller[0] ~= "x" then
			StorageCfg.setData("refill", citiesLootSeller)
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("initialsetup", "initial setup", {
		value="feyrist",
		title="Initial Setup",
		description="cities to sell supplies",
		multiline=false
	})
end

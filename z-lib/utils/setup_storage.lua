if not StorageConfig then
	StorageConfig = {
		refill = {},
		weaponId = "",
		ingame_hotkeys = "",
		exerciseWeaponId = "",
		cavebotProfile = "YalaharDragons",
		cavebotRefillLootSeller = "true",
		cavebotBlessings = "-Blessings-Walk"
	}
	vBotConfigSave("storage")
end

StorageCfg = {}

StorageCfg.setData = function(key, value)
	StorageConfig[key] = value
	vBotConfigSave("storage")
end

if CaveBot ~= nil and TargetBot ~= nil then
	TargetBot.setCurrentProfile("-Refill")
	CaveBot.setCurrentProfile("-Refill")
	CaveBot.setOff()
end

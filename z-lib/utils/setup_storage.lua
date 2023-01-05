if not StorageConfig then
	StorageConfig = {
		refill = {},
		weaponId = "",
		ingame_hotkeys = "",
		exerciseWeaponId = "",
		cavebotProfile = "-Refill-Depositor",
		cavebotRefill = "-Refill-Depositor",
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
	local currentProfile = StorageConfig.cavebotRefill or "-Refill-Depositor"
	TargetBot.setCurrentProfile(currentProfile)
	CaveBot.setCurrentProfile(currentProfile)
	CaveBot.setOff()
end

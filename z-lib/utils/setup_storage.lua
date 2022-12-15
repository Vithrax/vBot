if not StorageConfig then
	StorageConfig = {
		weaponId = "",
		exerciseWeaponId = "",
		cavebotProfile = "-Refill",
		cavebotChanged = false
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

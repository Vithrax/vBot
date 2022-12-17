if not StorageConfig then
	StorageConfig = {
		weaponId = "",
		exerciseWeaponId = "",
		cavebotProfile = "-Refill-Depositor",
		cavebotChanged = false,
		cavebotRefill = "-Refill-Depositor"
	}
	vBotConfigSave("storage")
end

StorageCfg = {}

StorageCfg.setData = function(key, value)
	StorageConfig[key] = value
	vBotConfigSave("storage")
end

if CaveBot ~= nil and TargetBot ~= nil then
	TargetBot.setCurrentProfile("-Refill-Depositor")
	CaveBot.setCurrentProfile("-Refill-Depositor")
	CaveBot.setOff()
end

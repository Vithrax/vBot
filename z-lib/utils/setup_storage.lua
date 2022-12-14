if not storage["playerInfo"] then
  storage["playerInfo"] = {}
end

if not storage["playerInfo"][player:getName()] then
  storage["playerInfo"][player:getName()] = {
		weaponId = "7434",
		exerciseWeaponId = "34303",
		cavebotProfile = "-Refill",
		cavebotChanged = false
	}
end

if CaveBot ~= nil and TargetBot ~= nil then
	TargetBot.setCurrentProfile("-Refill")
	CaveBot.setCurrentProfile("-Refill")
end

if not storage["playerInfo"] then
  storage["playerInfo"] = {}
end

if not storage["playerInfo"][player:getName()] then
  storage["playerInfo"][player:getName()] = {
		weaponId = "7434",
		exerciseWeaponId = "34299",
		cavebotProfile = "LavaLurkers",
		cavebotChanged = false
	}
end

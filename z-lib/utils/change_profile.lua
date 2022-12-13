if not HealBot or not AttackBot then
	return
end

if not storage["playerInfo"] then
  storage["playerInfo"] = {}
end

if not storage["playerInfo"][player:getName()] then
  storage["playerInfo"][player:getName()] = {
		weaponId = "7434",
		exerciseWeaponId = "34299",
		cavebotProfile = "LavaLurkers"
	}
end

local profileNumber = nil
local profileChars = {
	"Rotten Apple",
	"Head Creeps",
	"Junkhead",
	"Sludge Factory",
	"Them Bones"
}

for indexChar, profileChar in ipairs(profileChars) do
	if profileChar == player:getName() then
		profileNumber = indexChar
	end
end

if not profileNumber == nil then
	HealBotConfig.setActiveProfile(profileNumber)
	AttackBot.setActiveProfile(profileNumber)
end

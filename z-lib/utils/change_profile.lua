macro(1000, "change_profile", function()
	if not HealBot or not AttackBot then
		return
	end

	local profiles = {
		"Rotten Apple"=1,
		"Head Creeps"=2,
		"Junkhead"=3,
		"Sludge Factory"=4,
		"Them Bones"=5
	}

	if profiles[player:getName()] then
		local profileNumber = profiles[player:getName()]

		HealBot.setActiveProfile(profileNumber)
		AttackBot.setActiveProfile(profileNumber)
	end
end)

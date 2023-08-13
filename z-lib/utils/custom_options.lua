setDefaultTab("Main")

macro(500, "pause no bless + aol", function()
	local aol_id = 3057
	local hasnt_bless = player:getBlessings() == 0
	local hasnt_equipped = not getNeck() or getNeck():getId() ~= aol_id
	local has_aol = itemAmount(aol_id) >= 1

	if hasnt_bless and hasnt_equipped and has_aol then
		g_game.equipItemId(aol_id)
		return
	end

	if hasnt_bless and not has_aol then
		CaveBot.setOff()
	end
end)

UI.Label("CaveBot Profile:")
UI.TextEdit(storage_custom.cavebot_profile or "", function(widget, text)
	stg_custom.set_data("cavebot_profile", text)
end)

TargetBot.setCurrentProfile("__configuration")
CaveBot.setCurrentProfile("__configuration")
CaveBot.setOff()

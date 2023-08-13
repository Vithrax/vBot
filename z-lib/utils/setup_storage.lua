if not storage_custom then
	storage_custom = {
		weapon_id = "",
		exercise_id = "",
		ingame_hotkeys = "",
		last_quickloot = "",
		cavebot_profile = "",
	}
	vBotConfigSave("storage")
end

stg_custom = {}

stg_custom.set_data = function(key, value)
	storage_custom[key] = value
	vBotConfigSave("storage")
end

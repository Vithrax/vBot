if not storage_custom then
	storage_custom = {
		weapon_id = "",
		exercise_id = "",
		ingame_hotkeys = "",
		last_quickloot = "",
		cavebot_profile = "_configuration",
	}
	vBotConfigSave("storage")
end

stg_custom = {}

stg_custom.set_data = function(key, value)
	storage_custom[key] = value
	vBotConfigSave("storage")
end

stg_custom.set_quest = function(name, value)
	if not storage_custom["quests"] then
		storage_custom["quests"] = {}
	end
	storage_custom["quests"][name] = value
	vBotConfigSave("storage")
end

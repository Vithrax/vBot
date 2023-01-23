onTextMessage(function(mode, text)
	if string.find(text:lower(), "you are dead") then
		schedule(500, function()
			modules.game_cooldown.cooldown = {}
			modules.game_cooldown.cooldowns = {}
			modules.game_cooldown.groupCooldown = {}
			storage.teleporterLastTp = nil
			storage.teleporterLastTps = {}
		end)
	end
end)

modules.game_cooldown.cooldown = {}
modules.game_cooldown.cooldowns = {}
modules.game_cooldown.groupCooldown = {}
storage.teleporterLastTp = nil
storage.teleporterLastTps = {}

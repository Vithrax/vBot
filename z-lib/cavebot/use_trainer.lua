CaveBot.Extensions.UseTrainer = {}

CaveBot.Extensions.UseTrainer.setup = function()
	CaveBot.registerAction("UseTrainer", "#ffffff", function(value, retries)
		local data = regexMatch(value, "\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)")
		local tilePosition = {x=tonumber(data[1][2]), y=tonumber(data[1][3]), z=tonumber(data[1][4])}
		local exerciseWeaponId = tonumber(StorageConfig.exerciseWeaponId:trim()) or 34299
		local playerPosition = player:getPosition()

		if retries > 10 then
			return false
		end

		if getDistanceBetween(playerPosition, tilePosition) >= 5 then
			autoWalk(tilePosition, 100, {precision=2})
			return "retry"
		end

		local tile = g_map.getTile(tilePosition)
		local topUseThing = tile:getTopUseThing()

		useWith(exerciseWeaponId, topUseThing)

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("usetrainer", "use trainer", {
		value=function() return posx() .. ", " .. posy() .. ", " .. posz() end,
		title="Use Trainer",
		description="x, y, z",
		multiline=false,
		validation="^\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)$"
	})
end

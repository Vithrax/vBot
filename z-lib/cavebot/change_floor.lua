CaveBot.Extensions.ChangeFloor = {}

CaveBot.Extensions.ChangeFloor.setup = function()
	CaveBot.registerAction("ChangeFloor", "#ffffff", function(value, retries)
		local data = regexMatch(value, "\\s*([a-z]+)\\s*,\\s*([a-z]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)")
		local direction = data[1][2]
		local useItem = toBoolean(data[1][3])
		local tilePosition = {x=tonumber(data[1][4]), y=tonumber(data[1][5]), z=tonumber(data[1][6])}
		local playerPosition = player:getPosition()

		if retries > 10 then
			return false
		end

		if playerPosition.z == tilePosition.z and getDistanceBetween(playerPosition, tilePosition) >= 5 then
			autoWalk(tilePosition, 100, {precision=2})
			return "retry"
		end

		if playerPosition.z == tilePosition.z then
			local tile = g_map.getTile(tilePosition)
			local topUseThing = tile:getTopUseThing()

			if useItem then
				if direction == "up" then
					useWith(storage.extras.rope, topUseThing)
				else
					useWith(storage.extras.shovel, topUseThing)
					CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
					autoWalk(tilePosition, 100, {precision=0})
				end
			else
				use(topUseThing)
			end
			return "retry"
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("changefloor", "change floor", {
		value=function() return "up, true, " .. posx() .. ", " .. posy() .. ", " .. posz() end,
		title="Change floor",
		description="up/down, use rope/shovel, x, y, z",
		multiline=false,
		validation="^\\s*([a-z]+)\\s*,\\s*([a-z]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)$"
	})
end

CaveBot.Extensions.ExaniHur = {}

CaveBot.Extensions.ExaniHur.setup = function()
	CaveBot.registerAction("ExaniHur", "#ffffff", function(value, retries)
		local data = regexMatch(value, "\\s*([a-z]+)\\s*,\\s*([a-z]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)")
		local playerPosition = player:getPosition()
		local floor = data[1][2]
		local direction = data[1][3]
		local directions = {
			top=0,
			right=1,
			bottom=2,
			left=3
		}
		local tilePosition = {x=tonumber(data[1][4]), y=tonumber(data[1][5]), z=tonumber(data[1][6])}

		if retries > 10 then
			return false
		end

		if playerPosition.z == tilePosition.z and getDistanceBetween(playerPosition, tilePosition) >= 5 then
			autoWalk(tilePosition, 100, {precision=0})
			return "retry"
		end

		if playerPosition.z == tilePosition.z then
			turn(directions[direction])
			CaveBot.delay(500)
			cast("exani hur " .. floor)
			return "retry"
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("exanihur", "exani hur", {
		value=function() return "up, top, " .. posx() .. ", " .. posy() .. ", " .. posz() end,
		title="Exani hur",
		description="Exani hur up/down, direction top/right/bottom/left, x, y, z",
		multiline=false
	})
end

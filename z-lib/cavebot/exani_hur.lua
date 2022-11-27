CaveBot.Extensions.ExaniHur = {}

CaveBot.Extensions.ExaniHur.setup = function()
	CaveBot.registerAction("ExaniHur", "#ffffff", function(value, retries)
		local data = regexMatch(value, "\\s*([a-z]+)\\s*,\\s*([a-z]+)")
		local playerPosition = player:getPosition()
		local floor = data[1][2]
		local direction = data[1][3]
		local directions = {
			top=0,
			right=1,
			bottom=2,
			left=3
		}

		if retries > 10 then
			return false
		end

		turn(directions[direction])
		CaveBot.delay(500)
		cast("exani hur " .. floor)

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))

		local newPlayerPosition = player:getPosition()

		if newPlayerPosition.z == playerPosition.z then
			return "retry"
		end

		return true
	end)

	CaveBot.Editor.registerAction("exanihur", "exani hur", {
		value="up, top",
		title="Exani hur",
		description="Exani hur up/down, direction top, right, bottom, left",
		multiline=false
	})
end

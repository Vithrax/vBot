CaveBot.Extensions.SetBot = {}

CaveBot.Extensions.SetBot.setup = function()
	CaveBot.registerAction("SetBot", "#ffffff", function(value)
		local data = string.split(value, ",")
		local active = data[2]:trim()
		local bot = data[1]:trim()

		if (bot == "cave") then
			if active == "on" then
				CaveBot.setOn()
			else
				CaveBot.setOff()
			end
		else
			if active == "on" then
				TargetBot.setOn()
			else
				TargetBot.setOff()
			end
		end

		return true
	end)

	CaveBot.Editor.registerAction("setbot", "set bot", {
		value="target, on",
		title="Set CaveBot and TargetBot on/off",
		description="target/cave, on/off",
		multiline=false
	})
end

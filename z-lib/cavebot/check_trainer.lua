CaveBot.Extensions.CheckTrainer = {}

CaveBot.Extensions.CheckTrainer.setup = function()
	CaveBot.registerAction("CheckTrainer", "#ffffff", function(value)
		local data = string.split(value, ",")
		local labelToGo = data[1]:trim()
		local weaponId = tonumber(data[2]:trim())
		local STAMINA_LIMIT = 2519

		if getLeft() and getLeft():getId() == weaponId and stamina() < STAMINA_LIMIT then
			g_game.move(getLeft(), {x=65535, y=SlotBack, z=0}, 1)
		end
		if stamina() > STAMINA_LIMIT then
			g_game.move(findItem(weaponId), {x=65535, y=SlotLeft, z=0}, 1)
			gotoLabel(labelToGo)
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("checktrainer", "check trainer", {
		value="label, weaponId",
		title="Check trainer",
		description="Check if train or go hunt (label to go if stamina, weaponId)",
		multiline=false
	})
end

CaveBot.Extensions.CheckTrainer = {}

CaveBot.Extensions.CheckTrainer.setup = function()
	CaveBot.registerAction("CheckTrainer", "#ffffff", function(value)
		local data = string.split(value, ",")
		local labelToGo = data[1]:trim()
		local weaponId = tonumber(StorageConfig.weaponId:trim()) or 7434
		local exerciseWeaponId = tonumber(StorageConfig.exerciseWeaponId:trim()) or 34299
		local STAMINA_LIMIT = 2519
		local NO_WEAPON_LABEL = "buyExerciseWeapon"

		if itemAmount(exerciseWeaponId) < 1 then
			CaveBot.gotoLabel(NO_WEAPON_LABEL)
			return true
		end

		if getRight() and getRight():getId() == weaponId and stamina() < STAMINA_LIMIT then
			g_game.move(getRight(), {x=65535, y=SlotBack, z=0}, 1)
			CaveBot.delay(500)
		end
		if getLeft() and getLeft():getId() == weaponId and stamina() < STAMINA_LIMIT then
			g_game.move(getLeft(), {x=65535, y=SlotBack, z=0}, 1)
		end
		if stamina() > STAMINA_LIMIT then
			if player:getVocation() == 2 then
				g_game.move(findItem(weaponId), {x=65535, y=SlotRight, z=0}, 1)
				CaveBot.delay(500)
			end
			g_game.move(findItem(weaponId), {x=65535, y=SlotLeft, z=0}, 1)
			CaveBot.gotoLabel(labelToGo)
		end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		return true
	end)

	CaveBot.Editor.registerAction("checktrainer", "check trainer", {
		value="label",
		title="Check trainer",
		description="Check if train or go hunt (label to go if stamina is ok)",
		multiline=false
	})
end

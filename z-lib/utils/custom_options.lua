setDefaultTab("Main")

macro(1000, "equip aol", function()
	local AOL_ID = 3057
	if player:getBlessings() == 0 and (not getNeck() or getNeck():getId() ~= AOL_ID) then
		for _, container in pairs(g_game.getContainers()) do
			for __, item in ipairs(container:getItems()) do
				if item:getId() == AOL_ID then
					g_game.move(item, {x=65535, y=SlotNeck, z=0}, 1)
					return
				end
			end
		end
	end
end)

macro(1000, "pause cavebot bless", function()
	if player:getBlessings() == 0 then
		CaveBot.setOff()
	end
end)

UI.Label("Weapon ID:")
UI.TextEdit(StorageConfig.weaponId or "", function(widget, text)
	StorageCfg.setData("weaponId", text)
end)

UI.Label("Exercise Weapon ID:")
UI.TextEdit(StorageConfig.exerciseWeaponId or "", function(widget, text)
	StorageCfg.setData("exerciseWeaponId", text)
end)

UI.Label("CaveBot Profile:")
UI.TextEdit(StorageConfig.cavebotProfile or "-Refill-Depositor", function(widget, text)
	StorageCfg.setData("cavebotProfile", text)
end)

UI.Label("Refill Profile:")
UI.TextEdit(StorageConfig.cavebotRefill or "-Refill-Depositor", function(widget, text)
	StorageCfg.setData("cavebotRefill", text)
end)

UI.Label("Blessings Profile:")
UI.TextEdit(StorageConfig.cavebotBlessings or "-Blessings-Walk", function(widget, text)
	StorageCfg.setData("cavebotBlessings", text)
end)

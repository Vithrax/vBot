setDefaultTab("Main")

macro(250, "equip aol", function()
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

macro(1000, "pause cavebot bless+aol", function()
	local AOL_ID = 3057
	local cavebotBlessings = StorageConfig.cavebotBlessings or "-Blessings-Walk"

	if player:getBlessings() == 0 and (not getNeck() or getNeck():getId() ~= AOL_ID) and itemAmount(AOL_ID) < 1 then
		CaveBot.setOff()
	end

	if player:getBlessings() == 0 and CaveBot.getCurrentProfile() ~= cavebotBlessings then
		TargetBot.setCurrentProfile(cavebotBlessings)
		CaveBot.setCurrentProfile(cavebotBlessings)
		return
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
UI.TextEdit(StorageConfig.cavebotProfile or "-Refill", function(widget, text)
	StorageCfg.setData("cavebotProfile", text)
end)

UI.Label("CaveBot Refill Loot Seller:")
UI.TextEdit(StorageConfig.cavebotRefillLootSeller or "true", function(widget, text)
	StorageCfg.setData("cavebotRefillLootSeller", text)
end)

UI.Label("Blessings Profile:")
UI.TextEdit(StorageConfig.cavebotBlessings or "-Blessings-Walk", function(widget, text)
	StorageCfg.setData("cavebotBlessings", text)
end)

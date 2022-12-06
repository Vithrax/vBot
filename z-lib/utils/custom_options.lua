setDefaultTab("Main")

macro(1000, "equip aol", function()
	local AOL_ID = 3057
	if player:getBlessings() < 1 and (not getNeck() and not getNeck():getId() == AOL_ID) then
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
UI.TextEdit(storage["playerInfo"][player:getName()].weaponId or "7434", function(widget, text)
  storage["playerInfo"][player:getName()].weaponId = text
end)

UI.Label("Exercise Weapon ID:")
UI.TextEdit(storage["playerInfo"][player:getName()].exerciseWeaponId or "34299", function(widget, text)
  storage["playerInfo"][player:getName()].exerciseWeaponId = text
end)

UI.Label("CaveBot Profile:")
UI.TextEdit(storage["playerInfo"][player:getName()].cavebotProfile or "LavaLurkers", function(widget, text)
  storage["playerInfo"][player:getName()].cavebotProfile = text
end)

UI.Label("Refill Darashia:")
UI.TextEdit(storage["playerInfo"][player:getName()].refill.darashia or "false", function(widget, text)
  storage["playerInfo"][player:getName()].refill.darashia = text
end)

UI.Label("Refill Rathleton:")
UI.TextEdit(storage["playerInfo"][player:getName()].refill.rathleton or "false", function(widget, text)
  storage["playerInfo"][player:getName()].refill.rathleton = text
end)

UI.Label("Refill Farmine:")
UI.TextEdit(storage["playerInfo"][player:getName()].refill.farmine or "false", function(widget, text)
  storage["playerInfo"][player:getName()].refill.farmine = text
end)

UI.Label("Refill Gray Beach:")
UI.TextEdit(storage["playerInfo"][player:getName()].refill.graybeach or "false", function(widget, text)
  storage["playerInfo"][player:getName()].refill.graybeach = text
end)

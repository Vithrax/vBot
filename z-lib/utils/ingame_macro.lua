setDefaultTab("Tools")

macro(10000, "adeta res", function()
	if not isInPz() then
		cast("adeta res")
	end
end)

macro(1000, "pause cavebot bless", function()
	if player:getBlessings() == 0 then
		CaveBot.setOff()
	end
end)

macro(1000, "equip aol", function()
	if player:getBlessings() < 1 and (not getNeck() and notgetNeck():getId() == 3057) then
		for _, container in pairs(g_game.getContainers()) do
			for __, item in ipairs(container:getItems()) do
				if item:getId() == 3057 then
					g_game.move(item, {x=65535, y=SlotNeck, z=0}, 1)
					return
				end
			end
		end
	end
end)

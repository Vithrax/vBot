TaskBot.currentTask = nil

TaskBot.hasQuestStarted = function()
	if storage["playerStatus"][player:getName()]["quests"]["Killing in the Name of..."] then
		return true
	end
	return  false
end

TaskBot.isTaskCompleted = function(task)
	local normalized = task:gsub(" ", "")
	if table.find(TaskBot.tasksCompleted, normalized) then
		return true
	end
	return false
end

TaskBot.getNextTasks = function()
	local tasksToRequest = {}
	if #TaskBot.tasksInProgress < 3 then
		local playerTasks = storage["playerStatus"][player:getName()]["tasks"]
		local playerLevel = player:getLevel()
		local numberOfTasksToRequest = 3 - #TaskBot.tasksInProgress
		for index, value in pairs(TaskBot.taskList) do
			local task = value:gsub(" ", "")
			local isCompleted = TaskBot.isTaskCompleted(task)
			local hasConfig = CaveBot.configWidget.list:isOption(task)
			local alreadyInProgress = table.find(TaskBot.tasksInProgress, task)
			local hasLevel = (
				TaskBot.taskRequirements[task].maxLevel >= playerLevel and
				TaskBot.taskRequirements[task].minLevel <= playerLevel
			)
			if hasLevel and numberOfTasksToRequest > 0 and not isCompleted and not alreadyInProgress and hasConfig then
				table.insert(tasksToRequest, value)
				numberOfTasksToRequest = numberOfTasksToRequest - 1
			end
		end
	end
	return tasksToRequest
end

TaskBot.requestTasks = function(tasks)
	if type(tasks) == "string" then
		tasks = { tasks }
	end
	if type(tasks) == "table" and #tasks > 0 then
		local waitVal = 200
		local npc = getCreatureByName("Grizzly Adams")
		if not npc then
			print("CaveBot[requestTasks]: NPC not found.")
			return false
		end
		local pos = player:getPosition()
		local npcPos = npc:getPosition()
		if math.max(math.abs(pos.x - npcPos.x), math.abs(pos.y - npcPos.y)) > 3 then
			CaveBot.walkTo(npcPos, 20, {ignoreNonPathable = true, precision=3})
			delay(300)
			return "retry"
		end
		sayNpc("hi")
		for i, task in pairs(tasks) do
			schedule(i * waitVal + (i - 1) * waitVal, function() sayNpc(task) end)
			schedule(i * waitVal * 2, function() sayNpc("yes") end)
		end
		delay(waitVal * (2 * #tasks + 1))
	end
	return true
end

TaskBot.getCurrentTask = function()
	if #TaskBot.tasksInProgress > 0 then
		for index, value in pairs(TaskBot.taskList) do
			local task = value:gsub(" ", "")
			if table.find(TaskBot.tasksInProgress, task) then
				if not TaskBot.isTaskCompleted(task) and TaskBot.currentTask ~= task then
					TaskBot.currentTask = task
					break
				end
			end
		end
	end
end

TaskBot.jumpCurrentTask = function()
	local currentTaskFounded = false
	if type(TaskBot.currentTask) == "string" then
		for index, value in pairs(TaskBot.taskList) do
			local task = value:gsub(" ", "")
			if currentTaskFounded and table.find(TaskBot.tasksInProgress, task) then
				if not TaskBot.isTaskCompleted(task) and TaskBot.currentTask ~= task then
					TaskBot.currentTask = task
					break
				end
			end
			if task == TaskBot.currentTask then
				currentTaskFounded = true
			end
		end
	else
		TaskBot.getCurrentTask()
	end
end

TaskBot.loadTaskConfig = function(task)
	if not task then return false end
	local configName = task:gsub(" ", "")
	if CaveBot.configWidget.list:isOption(configName) and TargetBot.configWidget.list:isOption(configName) then
		CaveBot.configWidget.list:setOption(configName, false)
		TargetBot.configWidget.list:setOption(configName, false)
		return true
	else
		TaskBot.jumpCurrentTask()
		return "retry"
	end
end

TaskBot.loadManagerConfig = function(label)
	CaveBot.setOff()
	CaveBot.configWidget.list:setOption("TaskManager", false)
	schedule(1000, function()
		if label and type(label) == "string" then
			CaveBot.gotoLabel(label)
		end
		CaveBot.setOn()
	end)
end

local function botReconnect()
	local slot = #g_game["onGameStart"] + 1
	g_game["onGameStart"][slot] = function()
		local botWindow = rootWidget:recursiveGetChildById("botWindow")
		local config = botWindow:recursiveGetChildById("config")
		local button = botWindow:recursiveGetChildById("enableButton")
		if config:isOption("RichBot") then
				config:setOption("RichBot", false)
				if button:getText() == "Off" then
					button.onClick()
				end
				g_game["onGameStart"][slot] = nil
		end
	end
end

local charactersWindow = rootWidget:recursiveGetChildById("charactersWindow")
local autoReconnectButton = charactersWindow:getChildById('autoReconnect')
local characterList = charactersWindow:getChildById("characters")

TaskBot.setAutoReconnectOn = function()
	if not autoReconnectButton:isOn() then
		autoReconnectButton.onClick()
	end
end

TaskBot.setAutoReconnectOff = function()
	if autoReconnectButton:isOn() then
		autoReconnectButton.onClick()
	end
end

TaskBot.hasUnsetedCharacter = function()
	local children = characterList:getChildren()
	for _, character in pairs(children) do
		local characterName = character.characterName
		if not storage["playerStatus"][characterName] then
			return true
		end
	end
	return false
end

TaskBot.selectUnsetedCharacter = function()
	local children = characterList:getChildren()
	for i, character in pairs(children) do
		local characterName = character.characterName
		if not storage["playerStatus"][characterName] then
			characterList:focusChild(children[i], 1)
			TaskBot.setAutoReconnectOn()
			return true
		end
	end
	return true
end

TaskBot.selectCharWithIncompleteTasks = function()
	charactersWindow = rootWidget:recursiveGetChildById("charactersWindow")
	characterList = charactersWindow:getChildById("characters")
	local children = characterList:getChildren()
	for i, character in pairs(children) do
		local characterName = character.characterName
		local tasks = nil
		if storage["playerStatus"][characterName] then
			tasks = storage["playerStatus"][characterName]["tasks"]
		end
		if tasks and table.size(tasks) > 0 then
			for _, task in pairs(tasks) do
				if task.hunted < task.total then
					characterList:focusChild(children[i], 1)
					return true
				end
			end
		else
			characterList:focusChild(children[i], 1)
			return true
		end
	end
	return false
end

TaskBot.getCharWithIncompleteTasks = function()
	charactersWindow = rootWidget:recursiveGetChildById("charactersWindow")
	characterList = charactersWindow:getChildById("characters")
	local children = characterList:getChildren()
	for i, character in pairs(children) do
		local characterName = character.characterName
		local tasks = nil
		if storage["playerStatus"][characterName] then
			tasks = storage["playerStatus"][characterName]["tasks"]
		end
		if tasks and table.size(tasks) > 0 then
			for taskName, task in pairs(tasks) do
				if task.hunted < task.total then
					info("[248] Set label with: " .. characterName)
					return characterName
				end
			end
		else
			info("[253] Set label with: " .. characterName)
			return characterName
		end
	end
	info("[258] Set label with: false")
	return false
end

TaskBot.hasCharWithIncompleteTask = function()
	local children = characterList:getChildren()
	for i, character in pairs(children) do
		local characterName = character.characterName
		local tasks = storage["playerStatus"][characterName].tasks
		if #tasks > 0 then
			for _, task in pairs(tasks) do
				if task.hunted < task.total then
					return true
				end
			end
		else
			return true
		end
	end
	return false
end

local equipSlots = {
	[3392] = SlotHead,
	[3302] = SlotLeft,
	[10384] = SlotBody,
	[10387] = SlotLeg,
	[3079] = SlotFeet,
	[10388] = SlotLeft,
}

TaskBot.equipSet = function()
	for _, container in pairs(getContainers()) do
		if container:getName() == "wardrobe" or container:getName() == "treasure chest" or container:getContainerItem():getId() == 3504 then
			for i, item in pairs(container:getItems()) do
				local itemId = item:getId()
				if itemId ~= 3507 then
					g_game.move(item, {x=65535, y=equipSlots[itemId], z=0})
				end
			end
		end
	end
end

TaskBot.moveEquipsToWardrobe = function()
	local wardrobe = nil
	for _, container in pairs(getContainers()) do
		if container:getName() == "wardrobe" then
			wardrobe = container
			break
		end
	end
	if wardrobe then
		local retry = getHead() or getLeft() or getBody() or getLeg() or getFeet()
		g_game.move(getHead(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getLeft(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getBody(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getLeg(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getFeet(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		if retry then return "retry" end
	else
		CaveBot.gotoLabel("Transfer equips")
	end
	return true
end

TaskBot.moveEquipsToTreasureChest = function()
	local wardrobe = nil
	for _, container in pairs(getContainers()) do
		if container:getName() == "treasure chest" then
			wardrobe = container
			break
		end
	end
	if wardrobe then
		local retry = getHead() or getLeft() or getBody() or getLeg() or getFeet() or getFinger() or getRight() or getAmmo()
		g_game.move(getFeet(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getHead(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getLeft(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getBody(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getLeg(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getFinger(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getRight(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		g_game.move(getAmmo(), wardrobe:getSlotPosition(wardrobe:getItemsCount()), 1)
		if retry then return "retry" end
	else
		CaveBot.gotoLabel("Transfer equips")
	end
	return true
end

TaskBot.moveEquipsToParcel = function()
	local parcel = nil
	for _, container in pairs(getContainers()) do
		if container:getContainerItem():getId() == 3503 then
			parcel = container
			break
		end
	end
	if parcel then
		local retry = getHead() or getLeft() or getBody() or getLeg() or getFeet() or getFinger() or getRight() or getAmmo()
		g_game.move(getFeet(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getHead(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getLeft(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getBody(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getLeg(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getFinger(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getRight(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		g_game.move(getAmmo(), parcel:getSlotPosition(parcel:getItemsCount()), 1)
		if retry then return "retry" end
	end
	return true
end

TaskBot.loginNextCharacter = function()
	local children = characterList:getChildren()
	local nextCharacter = ""
	local hasNextCharacter = false
	for i=1, #children do
		local character = children[i]
		local characterName = character.characterName
		if storage["playerStatus"][characterName] then
			local characterTasks = storage["playerStatus"][characterName]["tasks"]
			if table.size(characterTasks) > 0 then
				for key, value in pairs(characterTasks) do
					if value["hunted"] < value["total"] then
						hasNextCharacter = true
						break
					end
				end
			else
				hasNextCharacter = true
			end
		else
			hasNextCharacter = true
		end
		if hasNextCharacter then
			characterList:focusChild(children[i], 1)
			if not autoReconnectButton:isOn() then
				autoReconnectButton.onClick()
			end
			break
		end
	end
end

local backExchangeMacro = nil
local runBackExchangeMacro = false

local function moveItemsFromBagToBackpack()
	local bagContainer = nil
	local backpackContainer = nil
	for _, container in pairs(getContainers()) do
		if container:getName() == "bag" then
			bagContainer = container
		elseif container:getName() == "backpack" then
			backpackContainer = container
		end
	end
	if bagContainer and backpackContainer then
		for _, item in pairs(bagContainer:getItems()) do
			if item:getId() ~= 2854 then
				g_game.move(item, backpackContainer:getSlotPosition(backpackContainer:getItemsCount()), item:getCount())
			end
		end
	end
end

local function openBackpackIntoBag()
	local bagContainer = nil
	local backpackContainer = nil
	for _, container in pairs(getContainers()) do
		if container:getName() == "bag" then
			bagContainer = container
		elseif container:getName() == "backpack" then
			backpackContainer = container
		end
	end
	if not backpackContainer then
		local backpack = findItem(2854)
		if backpack then
			g_game.open(backpack)
		end
	end
end

local function hasItemsInBag()
	for _, container in pairs(getContainers()) do
		if container:getName() == "bag" then
			for _, item in pairs(container:getItems()) do
				if item:getId() ~= 2854 then
					return true
				end
			end
			break
		end
	end
	return false
end

local function dropBag()
	local myPos = pos()
	local adjacents = myPos
	adjacents.x = myPos.x + math.random(-1, 1)
	adjacents.y = myPos.y + math.random(-1, 1)
	if getBack() and getBack():getId() == 2853 then
		g_game.move(getBack(), adjacents)
	end
end

local function equipBackpack()
	if not getBack() then
		for _, container in pairs(getContainers()) do
			if container:getName() == "bag" then
				for _, item in pairs(container:getItems()) do
					if item:getId() == 2854 then
						g_game.move(item, {x=65535, y=3, z=0})
						return
					end
				end
			end
		end
	end
end

backExchangeMacro = macro(500, function()
	if runBackExchangeMacro then
		if not getBack() or getBack():getId() ~= 2854 then
			openBackpackIntoBag()
			if hasItemsInBag() then
				moveItemsFromBagToBackpack()
			elseif getBack() and getBack():getId() == 2853 then
				dropBag()
			elseif not getBack() then
				equipBackpack()
			else
				runBackExchangeMacro = false
			end
		end
		return
	end
	backExchangeMacro.setOff()
end)


TaskBot.backExchange = function()
	if getBack() and getBack():getId() == 2854 then
		return true
	end
	runBackExchangeMacro = true
	backExchangeMacro.setOn()
	delay(5000)
	return "retry"
end

TaskBot.useAdventureStone = function()
	for _, container in pairs(getContainers()) do
		for _, item in pairs(container:getItems()) do
			if item:getId() == 16277 then
				use(item)
				return
			end
		end
	end
end

local dropLootMacroRunning = false
local droppedAllItems = false
local dropLootMacro = nil
dropLootMacro = macro(300, function()
	local hasItem = false
	for _, container in pairs(g_game.getContainers()) do
		for __, item in ipairs(container:getItems()) do
			local itemId = item:getId()
			local pos = pos()
			if itemId == 3043 then
				hasItem = true
				pos.x = 32610
				pos.y = 32759
				pos.z = 7
				return g_game.move(item, pos, item:getCount())
			end
			if itemId == 5883 then
				hasItem = true
				pos.x = 32611
				pos.y = 32759
				pos.z = 7
				return g_game.move(item, pos, item:getCount())
			end
			if itemId == 3348 then
				hasItem = true
				pos.x = 32612
				pos.y = 32759
				pos.z = 7
				return g_game.move(item, pos, item:getCount())
			end
		end
	end
	if not hasItem then
		droppedAllItems = true
	end
end)
dropLootMacro.setOff()

TaskBot.dropLoot = function()
	if droppedAllItems then
		droppedAllItems = false
		dropLootMacroRunning = false
		dropLootMacro.setOff()
		return true
	end
	if not dropLootMacroRunning then
		dropLootMacroRunning = true
		dropLootMacro.setOn()
	end
	return "retry"
end



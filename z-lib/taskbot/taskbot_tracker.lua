questLogButton = nil
questLineWindow = nil

questLogButtonClicked = false
questLineClicked = false
questLineClickedId = nil

rootWidget = g_ui.getRootWidget()

questLogButton = rootWidget:recursiveGetChildById("questLogButton")
local window = rootWidget:recursiveGetChildById("questLogWindow")

if questLogButton then
	questLogButton.onMouseRelease = function(widget, mousePos, mouseButton)
		if widget:containsPoint(mousePos) and mouseButton ~= MouseMidButton and mouseButton ~= MouseTouch then
			questLogButtonClicked = true
			g_game.requestQuestLog()
			return true
		end
	end
end

function show(questlog)
	if questlog then
		window:raise()
		window:show()
		window:focus()
		window.missionlog.currentQuest = nil
		window.questlog:setVisible(true)
		window.missionlog:setVisible(false)
		window.closeButton:setText('Close')
		window.showButton:setVisible(true)
		window.missionlog.track:setEnabled(false)
		window.missionlog.track:setChecked(false)
		window.missionlog.missionDescription:setText('')
	else
		window.questlog:setVisible(false)
		window.missionlog:setVisible(true)
		window.closeButton:setText('Back')
		window.showButton:setVisible(false)
	end
end

function showQuestLine()
	local questList = window.questlog.questList
	local child = questList:getFocusedChild()
	g_game.requestQuestLine(child.questId)
	window.missionlog.questName:setText(child.questName)
	window.missionlog.currentQuest = child.questId
end

function openQuestLogWindow(quests)
	show(true)
	local questList = window.questlog.questList
	questList:destroyChildren()
	for i, questEntry in pairs(quests) do
		local id = questEntry[1]
		local name = questEntry[2]
		local completed = questEntry[3]
		local questLabel = g_ui.createWidget('QuestLabel', questList)
		questLabel:setChecked(i % 2 == 0)
		questLabel.questId = id
		questLabel.questName = name
		name = completed and name.." (completed)" or name
		questLabel:setText(name)
		questLabel.onDoubleClick = function()
			window.missionlog.currentQuest = id
			questLineClicked = true
			questLineClickedId = id
			g_game.requestQuestLine(id)
			window.missionlog.questName:setText(questLabel.questName)
		end
	end
	questList:focusChild(questList:getFirstChild())
end

function openQuestLineWindow(questId, questMissions)
	show(false)
	local missionList = window.missionlog.missionList
	if questId == window.missionlog.currentQuest then
		missionList:destroyChildren()
	end
	for i,questMission in pairs(questMissions) do
		local name = questMission[1]
		local description = questMission[2]
		local missionLabel = g_ui.createWidget('QuestLabel', missionList)
		local widgetId = questId..'.'..i
		missionLabel:setChecked(i % 2 == 0)
		missionLabel:setId(widgetId)
		missionLabel.questId = questId
		missionLabel.trackData = widgetId
		missionLabel:setText(name)
		missionLabel.description = description
		missionLabel:setVisible(questId == window.missionlog.currentQuest)
	end
	local focusTarget = missionList:getFirstChild()
	if focusTarget and focusTarget:isVisible() then
		missionList:focusChild(focusTarget)
	end
end

if not storage["playerStatus"] then
	storage["playerStatus"] = {}
end

if not storage["playerStatus"][player:getName()] then
	storage["playerStatus"][player:getName()] = {
		quests = {},
		tasks = {}
	}
end

function questLogTracker(quests)
	if questLogButtonClicked then
		questLogButtonClicked = false
		openQuestLogWindow(quests)
	end
	for i = 1, #quests, 1 do
		local qid = quests[i][1]
		local name = quests[i][2]
		local isCompleted = quests[i][3]
		storage["playerStatus"][player:getName()]["quests"][name] = {
			id = qid,
			completed = isCompleted
		}
	end
end

function questLineTracker(questId, questMissions)
	if questLineClicked and questLineClickedId == questId then
		questLineClicked = false
		questLineClickedId = nil
		openQuestLineWindow(questId, questMissions)
	end

	if storage["playerStatus"][player:getName()]["quests"]["Killing in the Name of..."] and questId == storage["playerStatus"][player:getName()]["quests"]["Killing in the Name of..."]["id"] then
		for i = 1, #questMissions, 1 do
			local name = questMissions[i][1]
			local description = questMissions[i][2]
			if string.find(description, "You already hunted") then
				local monster = string.split( string.split( name, ":")[2], "(" )[1]:trim():gsub(" ", "")
				local progress = description:gsub("[^0-9/]", ""):trim()
				local monstersHunted = tonumber(string.split(progress, "/")[1])
				local monstersToHunt = tonumber(string.split(progress, "/")[2])
				if monstersHunted < monstersToHunt then
					if not table.find(TaskBot.tasksInProgress, monster) then
						table.insert(TaskBot.tasksInProgress, monster)
					end
				else
					if not table.find(TaskBot.tasksCompleted, monster) then
						table.insert(TaskBot.tasksCompleted, monster)
						table.removevalue(TaskBot.tasksInProgress, monster)
					end
				end
				storage["playerStatus"][player:getName()]["tasks"][monster] = {
					hunted = monstersHunted,
					total = monstersToHunt
				}
			end
		end
	end
end

g_game["onQuestLog"] = questLogTracker
g_game["onQuestLine"] = questLineTracker

onTalk(function(name, level, mode, text, channelId, pos)
	local lootChannel = getChannelId("loot channel")
	if (channelId == lootChannel) then
		local messageLabel = rootWidget:recursiveGetChildById("middleCenterLabel")
		messageLabel:setText(text)
		messageLabel:setColor('#ffffff')
		messageLabel:setVisible(true)
		messageLabel.hideEvent = schedule(math.max(#text * 50, 3000), function() messageLabel:setVisible(false) end)
	end
end)

function destroyWindows()
	if questLogWindow then
		questLogWindow:destroy()
	end
	if questLineWindow then
		questLineWindow:destroy()
	end
end

tasksTracker = macro(2000, function()
	g_game.requestQuestLog()
	if storage["playerStatus"][player:getName()]["quests"]["Killing in the Name of..."] then
		local id = storage["playerStatus"][player:getName()]["quests"]["Killing in the Name of..."]["id"]
		g_game.requestQuestLine(id)
	end
end)


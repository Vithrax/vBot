CaveBot.Extensions.TaskerCustom = {}

CaveBot.Extensions.TaskerCustom.setup = function()
	CaveBot.registerAction("TaskerCustom", "#ffffff", function(value)
		local data = string.split(value, ",")
		local taskStep = data[1]:trim()
		local taskName = data[2]:trim()
		local npcName = "Grizzly Adams"
		local defaultDelay = 750

		if taskStep == "start" then
			local taskAmount = tonumber(data[3]:trim())
			local taskMonsters = {}
			local messageList = {"task", taskName, "yes"}

			if not CaveBot.ReachNPC(npcName) then
				return "retry"
			end

			for index, monster in ipairs(data) do
				if index > 3 then
					taskMonsters.insert(monster:trim())
				end
			end

			NPC.say("hi")
			for index, message in ipairs(messageList) do
				if index > 1 then
					schedule(
						(index * defaultDelay),
						function()
							NPC.say(message:trim())
						end
					)
				end
			end

			startTask(taskName, taskAmount, taskMonsters)

			CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + ((tableLength(messageList) + 2) * defaultDelay))
		end

		if taskStep == "check" then
			local isDoneLabel = data[3]:trim()

			if checkTask(taskName) == true then
				CaveBot.gotoLabel(isDoneLabel)
			end

			CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
		end

		if taskStep == "report" then
			local messageList = {"report", "yes"}

			if not CaveBot.ReachNPC(npcName) then
				return "retry"
			end

			NPC.say("hi")
			for index, message in ipairs(messageList) do
				if index > 1 then
					schedule(
						(index * defaultDelay),
						function()
							NPC.say(message:trim())
						end
					)
				end
			end

			endTask(taskName)

			CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + ((tableLength(messageList) + 2) * defaultDelay))
		end

		return true
	end)

	CaveBot.Editor.registerAction("taskercustom", "tasker, custom", {
		value="start, tarantulas, 300",
		title="Tasker Custom",
		description="start/check/report, monster, kill count",
		multiline=false
	})
end

local regex = "Loot of ([a-z])* ([a-z A-Z]*):"
local regex2 = "Loot of ([a-z A-Z]*):"
onTextMessage(function(mode, text)
		if not text:lower():find("loot of") then return end
		if #regexMatch(text, regex) == 1 and #regexMatch(text, regex)[1] == 3 then
			monster = regexMatch(text, regex)[1][3]
		elseif #regexMatch(text, regex2) == 1 and #regexMatch(text, regex2)[1] == 2 then
			monster = regexMatch(text, regex2)[1][2]
		end

		if not storage.custom == nil and not storage.custom.tasks == nil then
			for _, task in ipais(storage.custom.tasks) do
				for __, monsterName in ipairs(task.monsters) do
					if monsterName === monster then
						task.count = task.count + 1
					end
				end
			end
		end
end)

TaskBot.loaded = false
TaskBot.tasksInProgress = {}
TaskBot.tasksCompleted = {}
TaskBot.taskCurrent = nil
TaskBot.taskProgress = {}

if not storage["playerStatus"] then
	storage["playerStatus"] = {}
end

if not storage["playerStatus"][player:getName()] then
	storage["playerStatus"][player:getName()] = {
		quests = {},
		tasks = {}
	}
end

if not TaskBot.loaded then
	local playerTasks = storage["playerStatus"][player:getName()]["tasks"]

	for taskName, task in ipairs(playerTasks) do
		if task.hunted >= task.total then
			table.insert(TaskBot.tasksCompleted, taskName)
		end
	end

	TaskBot.loaded = true
end

function startTask(taskName, taskAmount, taskMonsters)
	if storage.custom == nil then
		storage.custom = {}
	end
	if storage.custom.tasks == nil then
		storage.custom.tasks = {}
	end
	storage.custom.tasks.insert({
		name=taskName,
		amount=taskAmount,
		monsters=taskMonsters,
		count=0,
		done=false
	})
end

function checkTask(taskName)
	local isDone = false

	if not storage.custom == nil and not storage.custom.tasks == nil then
		for _, task in ipais(storage.custom.tasks) do
			if (task.name == taskName and task.amount <= task.count) or task.done == true then
				isDone = true
			end
		end
	end

	return isDone
end

function endTask(taskName)
	if not storage.custom == nil and not storage.custom.tasks == nil then
		for _, task in ipais(storage.custom.tasks) do
			if task.name == taskName then
				task.done = true
			end
		end
	end
end

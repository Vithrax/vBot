TaskBot.balance = 0
local withdrawMoneyMacro = nil
local withdrawMoneyMacroRunning = false
local withdrawAmount = 0
local drawned = false

withdrawMoneyMacro = macro(500, function()
	if TaskBot.balance > 0 then
		local remaining = TaskBot.balance % 10000
		withdrawAmount = TaskBot.balance - remaining - 10000
		if withdrawAmount < 0 then
			withdrawAmount = 1
		end
		schedule(1000, function()
			NPC.say("withdraw " .. tostring(withdrawAmount))
		end)
		schedule(1500, function()
			NPC.say("yes")
			withdrawMoneyMacroRunning = false
		end)
	end
end)

TaskBot.withdrawMoney = function()
	local wait = 500
	if drawned then
		drawned = false
		return true
	end
	if not withdrawMoneyMacroRunning then
		TaskBot.balance = 0
		NPC.say("hi")
		schedule(wait, function()
			NPC.say("balance")
		end)
		withdrawMoneyMacro.setOn()
		withdrawMoneyMacroRunning = true
	end
	return "retry"
end

onTalk(function(name, level, mode, text, channelId, pos)
	if (name == "Ferks") then
		local balance = string.match(text, ".*Your account balance is (%d+) gold.*")
		local drawn = string.match(text, ".*Here you are, (%d+) gold.*")
		if (balance) then
			TaskBot.balance = tonumber(balance)
		end
		if (drawn) then
			withdrawMoneyMacro.setOff()
			drawned = true
		end
	end
end)

CaveBot.Extensions.WithdrawBalance = {}
CaveBot.Extensions.WithdrawBalance.balance = 0

CaveBot.Extensions.WithdrawBalance.setup = function()
	CaveBot.registerAction("WithdrawBalance", "#ffffff", function(value)
		local npcName = value:trim()
		local defaultDelay = 750

		if not CaveBot.ReachNPC(npcName) then
			return "retry"
		end

		NPC.say("hi")
		schedule(defaultDelay, function()
			NPC.say("balance")
		end)
		schedule(defaultDelay*3, function()
			NPC.say("withdraw" .. CaveBot.Extensions.WithdrawBalance.balance)
		end)
		schedule(defaultDelay*5, function()
			NPC.say("yes")
		end)

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + defaultDelay*7)
		return true
	end)

	CaveBot.Editor.registerAction("withdrawbalance", "withdraw balance", {
		value="npcName",
		title="Withdraw balance",
		description="Withdraw all money on char balance",
		multiline=false
	})
end

onTalk(function(name, level, mode, text, channelId, pos)
	local bankNpcs = {
		"Atur", "Ebenizer", "Eighty", "Eva",
		"Ferks", "Finarfin", "Gnomillion", "Jefrey",
		"Jessica", "Kaya", "Kepar", "Lokur", "Murim",
		"Muzir", "Naji", "Paulie", "Plunderpurse",
		"Raffael", "Rokyn", "Siestaar", "Sissek",
		"Suzy", "Tesha", "Virgil", "Wentworth",
		"Znozel"
	}
	for _, nameNpc in ipairs(bankNpcs) do
		if nameNpc == name then
			local balance = string.match(text, ".*Your account balance is (%d+) gold.*")
			if (balance) then
				CaveBot.Extensions.WithdrawBalance.balance = tonumber(balance)
			end
			break
		end
	end
end)

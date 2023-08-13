CaveBot.Extensions.WithdrawBalance = {}
CaveBot.Extensions.WithdrawBalance.balance = 0

CaveBot.Extensions.WithdrawBalance.setup = function()
	CaveBot.registerAction("WithdrawBalance", "#ffffff", function(value)
		local npc_name = value:trim()
		local default_delay = 750

		if not CaveBot.ReachNPC(npc_name) then
			return "retry"
		end

		NPC.say("hi")
		schedule(default_delay, function()
			NPC.say("balance")
		end)
		schedule(default_delay*3, function()
			NPC.say("withdraw" .. CaveBot.Extensions.WithdrawBalance.balance)
		end)
		schedule(default_delay*5, function()
			NPC.say("yes")
		end)

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + default_delay*7)
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
	local bank_npcs = {
		"Atur", "Ebenizer", "Eighty", "Eva",
		"Ferks", "Finarfin", "Gnomillion", "Jefrey",
		"Jessica", "Kaya", "Kepar", "Lokur", "Murim",
		"Muzir", "Naji", "Paulie", "Plunderpurse",
		"Raffael", "Rokyn", "Siestaar", "Sissek",
		"Suzy", "Tesha", "Virgil", "Wentworth",
		"Znozel"
	}
	for _, npc_name in ipairs(bank_npcs) do
		if npc_name == name then
			local balance = string.match(text, ".*Your account balance is (%d+) gold.*")
			if (balance) then
				CaveBot.Extensions.WithdrawBalance.balance = tonumber(balance)
			end
			break
		end
	end
end)

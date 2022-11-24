CaveBot.Extensions.NpcTalk = {}

CaveBot.Extensions.NpcTalk.setup = function()
	CaveBot.registerAction("NpcTalk", "#ffffff", function(value, retries)
		local messageList = string.split(value, ",")
		local npcName = messageList[1]:trim()
		local defaultDelay = 500

		if not CaveBot.ReachNPC(npcName) then
			return "retry"
		end

	  NPC.say("hi")
	  for index, message in pairs(messageList) do

	    schedule(
	      (index * defaultDelay),
	      function()
	        NPC.say(message:trim())
	      end
	    )
	  end

		CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + ((tableLength(phrases) + 2) * defaultDelay))
		return true
	end)

	CaveBot.Editor.registerAction("npctalk", "npc talk", {
		value="npcName, message1, message2",
		description="messages to talk separated by comma(,)",
		multiline=false
	})
end
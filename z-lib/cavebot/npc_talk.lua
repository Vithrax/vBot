CaveBot.Extensions.NpcTalk = {}

CaveBot.Extensions.NpcTalk.setup = function()
  CaveBot.registerAction("NpcTalk", "#ffffff", function(value, retries)
    local messages = string.split(value, ",")
    local npc_name = messages[1]:trim()
    local npc = getCreatureByName(npc_name)

    if retries > 10 then
      print("CaveBot[NpcTalk]: Too many tries, can't talk")
      return false
    end

    if not npc then
      print("CaveBot[NpcTalk]: NPC not found")
      return false
    end

    if not CaveBot.ReachNPC(npc_name) then
      return "retry"
    end

    NPC.say("hi")
    for index, message in ipairs(messages) do
      if index > 1 then
        schedule(
          (index * storage.extras.talkDelay),
          function()
            NPC.say(message:trim())
          end
        )
      end
    end

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + ((table_length(messages) + 2) * storage.extras.talkDelay))
    return true
  end)

  CaveBot.Editor.registerAction("npctalk", "npc talk", {
    value="npcName, message1, message2",
    description="messages to talk separated by comma(,)",
    multiline=false
  })
end

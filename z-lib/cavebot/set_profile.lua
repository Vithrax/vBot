CaveBot.Extensions.SetProfile = {}

CaveBot.Extensions.SetProfile.setup = function()
  CaveBot.registerAction("SetProfile", "#ffffff", function(value)
    if not string.find(value, "__") then
      TargetBot.setCurrentProfile(value)
    end
    CaveBot.setCurrentProfile(value)

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
    return true
  end)

  CaveBot.Editor.registerAction("setprofile", "set profile", {
    value="-Refill",
    title="Set profile",
    description="Set CaveBot and TargetBot profile",
    multiline=false
  })
end

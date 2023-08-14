CaveBot.Extensions.InitialSetup = {}

CaveBot.Extensions.InitialSetup.setup = function()
  CaveBot.registerAction("InitialSetup", "#ffffff", function(value)
    local supply_data = Supplies.hasEnough()
    local supply_info = Supplies.getAdditionalData()
    local has_to_refill = storage.caveBot.forceRefill
                        or storage.caveBot.backStop
                        or storage.caveBot.backTrainers
                        or storage.caveBot.backOffline
                        or type(supply_data) == "table"
                        or (supply_info.stamina.enabled and stamina() < tonumber(supply_info.stamina.value))
                        or (supply_info.capacity.enabled and freecap() < tonumber(supply_info.capacity.value))

    TargetBot.setCurrentProfile(CaveBot.getCurrentProfile())

    if has_to_refill then
      TargetBot.setCurrentProfile("__configuration")
      CaveBot.setCurrentProfile("__configuration")
    end

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
    return true
  end)

  CaveBot.Editor.registerAction("initialsetup", "initial setup", {
    value="_",
    title="Initial Setup",
    description="check refill properties",
    multiline=false
  })
end

CaveBot.Extensions.SimpleCheck = {}

CaveBot.Extensions.SimpleCheck.setup = function()
  CaveBot.registerAction("SimpleCheck", "#ffffff", function(value)
    local supply_data = Supplies.hasEnough()
    local supply_info = Supplies.getAdditionalData()
    local has_to_refill = storage.caveBot.forceRefill
                        or storage.caveBot.backStop
                        or storage.caveBot.backTrainers
                        or storage.caveBot.backOffline
                        or type(supply_data) == "table"
                        or (supply_info.capacity.enabled and freecap() < tonumber(supply_info.capacity.value))

    if not has_to_refill then
      CaveBot.gotoLabel(value)
    end

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
    return true
  end)

  CaveBot.Editor.registerAction("simplecheck", "simple check", {
    value="starthunt",
    title="Simple check",
    description="Simple supply check",
    multiline=false
  })
end

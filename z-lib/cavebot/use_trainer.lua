CaveBot.Extensions.UseTrainer = {}

CaveBot.Extensions.UseTrainer.setup = function()
  CaveBot.registerAction("UseTrainer", "#ffffff", function(value, retries)
    local value_split = regexMatch(value, "\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)")
    local coordinates = {x=tonumber(value_split[1][2]), y=tonumber(value_split[1][3]), z=tonumber(value_split[1][4])}
    local player_position = player:getPosition()

    if retries > 10 then
      return false
    end

    if getDistanceBetween(player_position, coordinates) >= 5 then
      autoWalk(coordinates, 100, {precision=2})
      return "retry"
    end

    local tile = g_map.getTile(coordinates)
    useWith(storage_custom.exercise_id, tile:getTopUseThing())

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping"))
    return true
  end)

  CaveBot.Editor.registerAction("usetrainer", "use trainer", {
    value=function() return posx() .. ", " .. posy() .. ", " .. posz() end,
    title="Use Trainer",
    description="x, y, z",
    multiline=false,
    validation="^\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*,\\s*([0-9]+)$"
  })
end

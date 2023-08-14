CaveBot.Extensions.SetQuickloot = {}

CaveBot.Extensions.SetQuickloot.setup = function()
  CaveBot.registerAction("SetQuickloot", "#ffffff", function(value)
    local item_list = string.split(value, ",")
    local default_delay = 5000

    if storage_custom.last_quickloot == value then
      return true
    end

    NPC.say("!quickloot clear")
    for index, item in pairs(item_list) do
      schedule(
        (index * default_delay),
        function()
          local itemTrim = item:trim()
          NPC.say("!quickloot add," .. itemTrim)
        end
      )
    end
    stg_custom.set_data('last_quickloot', value)

    CaveBot.delay(CaveBot.Config.get("useDelay") + CaveBot.Config.get("ping") + ((table_length(item_list) + 2) * default_delay))
    return true
  end)

  CaveBot.Editor.registerAction("setquickloot", "set quickloot", {
    value="item1, item2, item3",
    title="Set Quickloot",
    description="Set items for be taken in Quickloot",
    multiline=false
  })
end

-- Cavebot by otclient@otclient.ovh
-- visit http://bot.otclient.ovh/

local cavebotTab = "Cave"
local targetingTab = "Target"

setDefaultTab(cavebotTab)
CaveBot = {} -- global namespace
CaveBot.Extensions = {}
importStyle("/pre/cavebot/cavebot.otui")
importStyle("/pre/cavebot/config.otui")
importStyle("/pre/cavebot/editor.otui")
importStyle("/pre/cavebot/supply.otui")
dofile("/pre/cavebot/actions.lua")
dofile("/pre/cavebot/config.lua")
dofile("/pre/cavebot/editor.lua")
dofile("/pre/cavebot/example_functions.lua")
dofile("/pre/cavebot/recorder.lua")
dofile("/pre/cavebot/walking.lua")
-- in this section you can add extensions, check extension_template.lua
--dofile("/pre/cavebot/extension_template.lua")
dofile("/pre/cavebot/sell_all.lua")
dofile("/pre/cavebot/depositor.lua")
dofile("/pre/cavebot/buy_supplies.lua")
dofile("/pre/cavebot/d_withdraw.lua")
dofile("/pre/cavebot/depositer.lua")
dofile("/pre/cavebot/supply.lua")
dofile("/pre/cavebot/supply_check.lua")
dofile("/pre/cavebot/travel.lua")
dofile("/pre/cavebot/doors.lua")
dofile("/pre/cavebot/pos_check.lua")
dofile("/pre/cavebot/withdraw.lua")
dofile("/pre/cavebot/inbox_withdraw.lua")
dofile("/pre/cavebot/lure.lua")
dofile("/pre/cavebot/bank.lua")
dofile("/pre/cavebot/depositer.lua")
dofile("/pre/cavebot/supply.lua")
dofile("/pre/cavebot/clear_tile.lua")
dofile("/pre/cavebot/tasker.lua")
-- main cavebot file, must be last
dofile("/pre/cavebot/cavebot.lua")

setDefaultTab(targetingTab)
TargetBot = {} -- global namespace
importStyle("/pre/targetbot/looting.otui")
importStyle("/pre/targetbot/target.otui")
importStyle("/pre/targetbot/creature_editor.otui")
dofile("/pre/targetbot/creature.lua")
dofile("/pre/targetbot/creature_attack.lua")
dofile("/pre/targetbot/creature_editor.lua")
dofile("/pre/targetbot/creature_priority.lua")
dofile("/pre/targetbot/looting.lua")
dofile("/pre/targetbot/walking.lua")
-- main targetbot file, must be last
dofile("/pre/targetbot/target.lua")

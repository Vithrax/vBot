--[[
Configs for modules
Based on Kondrah storage method
--]]
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

-- make vBot config dir
if not g_resources.directoryExists("/bot/".. configName .."/vBot_configs/"..player:getName().."/") then
  g_resources.makeDir("/bot/".. configName .."/vBot_configs/"..player:getName().."/")
end

HealBotConfig = {}
local healBotFile = "/bot/" .. configName .. "/vBot_configs/".. player:getName() .."/HealBot.json"
AttackBotConfig = {}
local attackBotFile = "/bot/" .. configName .. "/vBot_configs/".. player:getName() .."/AttackBot.json"
SuppliesConfig = {}
local suppliesFile = "/bot/" .. configName .. "/vBot_configs/".. player:getName() .."/Supplies.json"
storage_custom = {}
local storageFile = "/bot/" .. configName .. "/vBot_configs/".. player:getName() .."/Storage.json"
quests_config = {}
local questsFile = "/bot/" .. configName .. "/vBot_configs/".. player:getName() .."/Quests.json"
containers_config = {}
local containersFile = "/bot/" .. configName .. "/vBot_configs/".. player:getName() .."/Containers.json"

--healbot
if g_resources.fileExists(healBotFile) then
  local status, result = pcall(function()
    return json.decode(g_resources.readFileContents(healBotFile))
  end)
  if not status then
    return onError("Error while reading config file (" .. healBotFile .. "). To fix this problem you can delete HealBot.json. Details: " .. result)
  end
  HealBotConfig = result
end

--attackbot
if g_resources.fileExists(attackBotFile) then
  local status, result = pcall(function()
    return json.decode(g_resources.readFileContents(attackBotFile))
  end)
  if not status then
    return onError("Error while reading config file (" .. attackBotFile .. "). To fix this problem you can delete HealBot.json. Details: " .. result)
  end
  AttackBotConfig = result
end

--supplies
if g_resources.fileExists(suppliesFile) then
  local status, result = pcall(function()
    return json.decode(g_resources.readFileContents(suppliesFile))
  end)
  if not status then
    return onError("Error while reading config file (" .. suppliesFile .. "). To fix this problem you can delete HealBot.json. Details: " .. result)
  end
  SuppliesConfig = result
end

--storage
if g_resources.fileExists(storageFile) then
  local status, result = pcall(function()
    return json.decode(g_resources.readFileContents(storageFile))
  end)
  if not status then
    return onError("Error while reading config file (" .. storageFile .. "). To fix this problem you can delete HealBot.json. Details: " .. result)
  end
  storage_custom = result
end

--quests
if g_resources.fileExists(questsFile) then
  local status, result = pcall(function()
    return json.decode(g_resources.readFileContents(questsFile))
  end)
  if not status then
    return onError("Error while reading config file (" .. questsFile .. "). To fix this problem you can delete HealBot.json. Details: " .. result)
  end
  quests_config = result
end

--containers
if g_resources.fileExists(containersFile) then
  local status, result = pcall(function()
    return json.decode(g_resources.readFileContents(containersFile))
  end)
  if not status then
    return onError("Error while reading config file (" .. containersFile .. "). To fix this problem you can delete HealBot.json. Details: " .. result)
  end
  containers_config = result
end

function vBotConfigSave(file)
  -- file can be either
  --- heal
  --- atk
  --- supply
  --- storage
  local configFile
  local configTable
  if not file then return end
  file = file:lower()
  if file == "heal" then
    configFile = healBotFile
    configTable = HealBotConfig
  elseif file == "atk" then
    configFile = attackBotFile
    configTable = AttackBotConfig
  elseif file == "supply" then
    configFile = suppliesFile
    configTable = SuppliesConfig
  elseif file == "storage" then
    configFile = storageFile
    configTable = storage_custom
  elseif file == "quests" then
    configFile = questsFile
    configTable = quests_config
  elseif file == "containers" then
    configFile = containersFile
    configTable = containers_config
  else
    return
  end

  local status, result = pcall(function()
    return json.encode(configTable, 2)
  end)
  if not status then
    return onError("Error while saving config. it won't be saved. Details: " .. result)
  end

  if result:len() > 100 * 1024 * 1024 then
    return onError("config file is too big, above 100MB, it won't be saved")
  end

  g_resources.writeFileContents(configFile, result)
end

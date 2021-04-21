local isBotOldVersion = false
local directoryBotPrefix = "/bot/vBot/pre/"

-- to ensure backwards compatibility
if isBotOldVersion then
    local preFiles = g_resources.listDirectoryFiles(directoryBotPrefix, false, true)

    local luaFiles = {}
    local uiFiles = {}
    for i, file in ipairs(preFiles) do
        local ext = file:split(".")
        if ext[#ext]:lower() == "lua" then
            table.insert(luaFiles, file)
        end
        if ext[#ext]:lower() == "ui" or ext[#ext]:lower() == "otui" then
            table.insert(uiFiles, file)
        end
    end

    -- run ui scripts
    for i, file in ipairs(uiFiles) do
        g_ui.importStyle(directoryBotPrefix .. file)
    end

    -- run lua script
    for i, file in ipairs(luaFiles) do
        dofile("pre/" .. file)
    end
else
    -- main of new bot version
    Tabs = {}


    -- load libraries
    dofile('library/constant.lua')
    dofile('library/item.lua')
    dofile('library/self.lua')
    dofile('library/container.lua')
    dofile('library/creature.lua')
    dofile('library/event.lua')
    dofile('library/utils.lua')

    -- load modules/tabs
    dofile("/tabs/main/main.lua")
    dofile("/tabs/support/main.lua")
    dofile("/tabs/cave/main.lua")
    dofile("/tabs/target/main.lua")
end

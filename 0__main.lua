local isBotOldVersion = true
local directoryBotPrefix = "/bot/vBot/pre/"

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
    --
    --for index, file in pairs(preFiles) do
    --    if file:ends(".otui") then
    --        g_ui.importStyle("pre/" .. file)
    --    else
    --        dofile("pre/" .. file)
    --    end
    --end
end

-- load libraries
dofile('library/constant.lua')
dofile('library/item.lua')
dofile('library/self.lua')
dofile('library/container.lua')
dofile('library/creature.lua')
dofile('library/event.lua')
dofile('library/utils.lua')
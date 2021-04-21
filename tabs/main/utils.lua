local scriptsPath = "/bot/vBot/scripts/"

Tabs.Main.Utils = {}

function Tabs.Main.Utils.getAvailableScripts()
    local availableScripts = {}
    for _, scriptFile in ipairs(g_resources.listDirectoryFiles(scriptsPath)) do
        local path = scriptsPath .. scriptFile
        if g_resources.fileExists(path) then
            availableScripts[#availableScripts + 1] = decode(g_resources.readFileContents(path))
        end
    end

    return availableScripts
end
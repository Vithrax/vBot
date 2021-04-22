panelName = "Scripts"

local scriptsPanel = UI.createWidget("ScriptsPanel")

local function showScriptsLabels(scriptsList)
    for _, script in pairs(scriptsList) do
        local scriptLabel = UI.createWidget('ScriptName', scriptsPanel.ScriptsList)
        scriptLabel:setId('script-' .. script.name)
        scriptLabel:setTextAlign(AlignLeft)
        scriptLabel:setText(script.name)
        scriptLabel:show()
    end
end

showScriptsLabels(Tabs.Main.Utils.getAvailableScripts())
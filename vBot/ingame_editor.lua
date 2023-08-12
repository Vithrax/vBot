setDefaultTab("Tools")
-- allows to test/edit bot lua scripts ingame, you can have multiple scripts like this, just change storage.ingame_lua
UI.Button("Ingame script editor", function(newText)
    UI.MultilineEditorWindow(storage_custom.ingame_hotkeys or "", {title="Hotkeys editor", description="You can add your custom scrupts here"}, function(text)
      stg_custom.set_data("ingame_hotkeys", text)
      reload()
    end)
  end)

  UI.Separator()

  for _, scripts in pairs({storage_custom.ingame_hotkeys}) do
    if type(scripts) == "string" and scripts:len() > 3 then
      local status, result = pcall(function()
        assert(load(scripts, "ingame_editor"))()
      end)
      if not status then
        error("Ingame edior error:\n" .. result)
      end
    end
  end

  UI.Separator()

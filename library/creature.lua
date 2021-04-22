Creature = {}
Creature.__index = Creature


function Creature.getSpectators(multifloor)
    for index, spec in pairs(getSpectators(multifloor or false)) do
        print("index " .. index)
        print("spec " .. tostring(spec))
    end
end
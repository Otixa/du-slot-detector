function SlotDetector(container)
    if not container then container = _G end
    local slots = {Engines={}, SpaceFuelTanks={}, AtmoFuelTanks={}, Core=nil}
    for slotName,var in pairs(container) do
        if type(var) == "function" then goto continue end
        if not var["getId"] then goto continue end
        if var["getConstructWorldPos"] then slots.Core = var goto continue end
        if var["getMaxThrust"] then table.insert(slots.Engines, var) goto continue end
        if var["getSelfMass"] then
            --Is Fuel/Container
            local mass = var["getSelfMass"]
            goto continue
        end

        ::continue::
    end
    return slots
end

function ScopePromoter(source, dest)
    for slotName,var in pairs(source) do
        if type(var) == "function" then goto continue end
        if not var["getId"] then goto continue end
        dest[slotName]=var
        ::continue::
    end
end
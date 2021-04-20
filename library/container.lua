Container = {}
Container.__index = Container


--- Creates a container object from given value.
-- Creates and returns a container object using it's a name, itemId, or index.
-- @param value the containers's name, itemId, or index
-- @return object Container
function Container.New(value)
    local c, isString = {}, type(value) == 'string'

    if (value == nil) then
        c._index = -1
    else
        setmetatable(c, Container)
        if (isString or value > 99) then
            local index = -1
            while (index < 16) do
                index = index + 1
                if (g_game.getContainer(index)) then
                    local name = isString and value or Thing.GetItemNameById(value)
                    if (Container.GetOpenedContainerNameByIndex(index) == name) then
                        break
                    end
                end
            end
            value = index
        end
        c._index = g_game.getContainer(value) and value or -1
    end
    return c
end
setmetatable(Container, { __call = function(_, ...)
    return Container.New(...)
end })

--- Returns whether container has all slots used.
-- @return boolean whether container is full
function Container:isFull()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return #self:getItems() >= self:getCapacity()
end

--- Returns container's id.
-- @return number total slots
function Container:getId()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return g_game.getContainer(self._index):getContainerItem():getId()
end

--- Returns container's item capacity.
-- Returns the total amount of slots the container has.
-- @return number total slots
function Container:getCapacity()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return g_game.getContainer(self._index):getCapacity()
end

--- Returns whether container has parent.
-- @return boolean whether has parent
function Container:hasParent()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return g_game.getContainer(self._index):hasParent()
end

--- Get container's item list.
-- Returns the total amount of slots the container has.
-- @return table container items
function Container:getItems()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return g_game.getContainer(self._index):getItems()
end

--- Get container's name.
-- As it uses getting name from market data might not work for before market clients.
-- @return number total slots
function Container:getName()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return Thing.GetItemNameById(g_game.getContainer(self._index):getContainerItem():getId())
end

--- Closes container.
-- @return number total slots
function Container:close()
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    return g_game.close(g_game.getContainer(self._index))
end

--- Opens container's child.
-- @param child container's child to open
-- @return boolean whether succeed
function Container:openChild(child)
    self = type(self) == 'table' and self or Container.New(self)
    if self._index == -1 then
        return nil
    end
    for _, container in pairs(Container.GetOpenedContainers()) do
        for _, item in pairs(container:getItems()) do
            if item:getId() == containerId then
                g_game.open(item)
            end
        end
    end

    return false
end

--- Returns all opened containers objects.
-- @return nil or table of containers
function Container.GetOpenedContainers()
    local containers = {}
    for index, container in pairs(getContainers()) do
        table.insert(containers, Container.New(index))
    end

    return containers
end

--- Get container object by its name. Container must be visible.
-- @param name container's name
-- @return nil or container
function Container.GetOpenedContainerNameByIndex(index)
    for containerIndex, container in pairs(Container.GetOpenedContainers()) do
        if containerIndex == index + 1 then
            return container:getName()
        end
    end

    return nil
end

--- Get container object by its name. Container must be visible.
-- @param name container's name
-- @return nil or container
function Container.GetOpenedContainerById(id)
    for _, container in pairs(Container.GetOpenedContainers()) do
        if container:getId() == id then
            return container
        end
    end

    return nil
end

--- Opens main container.
-- Opens main container checking first if container with id same as main backpack id is already opened.
-- @param forceReset when enabled closes main backpack by using back slot and opens again
-- @return void
function Container.OpenMain(forceReset)
    local mainBackpack = Container.GetOpenedContainerById(Self.GetMainBackpackId())
    if not mainBackpack then
        Self.UseMainBackpack()
    elseif forceReset then
        Self.UseMainBackpack()
        Self.UseMainBackpack()
    end
end

--- Closes all containers.
-- Closes all opened containers.
-- @return void
function Container.CloseAllContainers()
    for _, container in pairs(Container.GetOpenedContainers()) do
        container:close()
    end
end


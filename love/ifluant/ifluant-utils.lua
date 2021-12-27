-- utilities, move this somewhere
function printtable(t)
    for i,v in pairs(t) do
        print(i..'..'..tostring(v))
    end
end

function capitalize(s)
    return string.upper(string.sub(s,1,1)) .. string.sub(s, 2, #s)
end

function bold(s)
    io.write('\27[1m'..s..'\27[0m')
end

function article(obj)
    local article = 'A';
    if (obj.article) then article = capitalize(obj.article) end
    return article
end

function say(s)
    io.write(s .. '\n\n')
end

-- Shortcut functions
function go(room)
    return function() return rooms[room] end
end

-- Say something before normal operations, then continue
function flavor(text)
    return function() print(text) end
end

-- Describe what's happening, then let the action happen
function describe(text)
    return function() print(text) return false, true end
end

-- Only show or do something and then stop
function perform(o)
    return function()
        if type(o) == 'string' then
            print(o)
        elseif type(o) == 'function' then
            o()
        end
        return true, true 
    end
end

function player.moveTo(_room)
    player.room = _room
    player.moved = true
end

function giveItem(item, target)
    table.insert(target.holding, item)
end

function moveItem(item, source, target)
    local moved = false
    for i,v in pairs(source.holding) do
        if (v == item) then
            source.holding[i] = nil
            table.insert(target.holding, item)
            moved = true
        end
    end
    return moved
end

function findObject(obj)
    if obj then
        for k, v in pairs(items) do
            if itemMatches(v, obj) then
                return k
            end
        end
    end
end
     
function isLit(room)
    local isLit = room.lighted
    if not isLit then
        for i,v in pairs(room.holding) do
            if items[v].giveslight then
                isLit = true
                break
            end
        end
        for i,v in pairs(player.holding) do
            if items[v].giveslight then
                isLit = true
                break
            end
        end
    end
    return isLit
end

function showRoomContents(room)
    if isLit(room) then 
        if (room.holding) then
            local started
            for i,v in pairs(room.holding) do
                if not items[v].hidden then 
                    if not started then
                        print("\nYou see:")
                        started = true
                    end
                    print("   "..article(items[v]).." " .. items[v].name)
                end
            end
        end
    end
end

function showRoom(room)
    if isLit(room) then
        if (type(room.desc) == 'string') then
            print(room.desc)
        elseif (type(room.desc) == 'function') then
            room.desc()
        end
    else
        print("It is too dark to see.")
    end
end
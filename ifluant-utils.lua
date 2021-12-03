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

function go(room)
    return function() return rooms[room] end
end

function player.moveTo(_room)
    player.room = _room
    player.moved = true
end

function giveItem(item, target)
    if not target.holding then
        target.holding = {}
    end
    table.insert(target.holding, item)
end

function moveItem(item, source, target)
    local moved = false
    for i,v in pairs(source.holding) do
        if (v == item) then
            source.holding[i] = nil
            if not target.holding then
                target.holding = {}
            end
            table.insert(target.holding, item)
            moved = true
        end
    end
    return moved
end

function showRoomContents(room)
    if (room.holding and #room.holding > 0) then
        print("\nYou see:")
        for i,v in pairs(room.holding) do
            print("   "..article(v).." " .. v.name)
        end
    end
end

function showRoom(room)
    print(room.desc)
end
function itemMatches(item, str)
    for i,v in pairs(item.names) do
        if (v == str) then return true end
    end
    return false
end

function dirHandler(v)
    local dest = player.room.dirs[v]
    if not dest then
        print("You can't go that way.")
    else
        if (type(dest) == 'string') then
            print(dest)
        elseif (type(dest) == 'function') then
            local res = dest()
            if (type(res) == 'table') then player.moveTo(res) end
        else
            print("ERROR: invalid room direction type: " .. type(dest))
            os.exit();
        end
    end
end

function initVerbs()
    local verbs = {
        n = {
            synonyms = {'north'},
            handler = dirHandler
        },
        s = {
            synonyms = {'south'},
            handler = dirHandler
        },
        e = {
            synonyms = {'east'},
            handler = dirHandler
        },
        w = {
            synonyms = {'west'},
            handler = dirHandler
        },
        quit = {
            synonyms = {'q'},
            handler = function()
                gamestate.quit = true
            end
        },
        inventory = {
            synonyms = {'i', 'inv'},
            handler = function()
                if (#player.holding == 0) then
                    print('You are empty-handed.')
                else
                    print('You are carrying:')
                    for i,v in pairs(player.holding) do
                        print("   "..article(items[v]).." " .. items[v].name)
                    end
                end
            end
        },
        look = {
            synonyms = {'l'},
            handler = function()
                print(bold(player.room.shortdesc))
                showRoom(player.room)
                showRoomContents(player.room)
            end
        },
        get = {
            synonyms = {'take'},
            handler = function(verb, obj, hook)
                if not obj then
                    print("What do you want to get?")
                    return
                end
                for i,v in pairs(player.holding) do
                    if obj == v then
                        print("You're already carrying the "..items[v].name..".")
                        return
                    end
                end
                for i,v in pairs(player.room.holding) do
                    if obj == v then
                        local halt, overrideText
                        if hook then
                            halt, overrideText = hook()
                        end

                        if halt then return end

                        if (not overrideText) then
                            print('You pick up the '..items[v].name..'.')
                        end
                        moveItem(v, player.room, player)
                        return
                    end
                end
                print("You don't see any " .. obj .. " here.")
            end
        },
        drop = {
            handler = function(verb, obj, hook)
                if not obj then
                    print("What do you want to drop?")
                    return
                end
                for i,v in pairs(player.holding) do
                    if (obj == v) then
                        local halt, overrideText
                        if hook then
                            halt, overrideText = hook()
                        end
                        if halt then return end
                        if (not overrideText) then
                            print('You drop the '..items[v].name..'.')
                        end
                        moveItem(v, player, player.room)
                        return
                    end
                end
                print("You're not carrying any " .. obj .. ".")
            end
        },
        examine = {
            synonyms = { 'x' },
            handler = function(verb, obj)
                if not obj then
                    print("What do you want to examine?")
                    return
                end
                local item
                for i,v in pairs(player.holding) do
                    if obj == v then
                        item = v
                    end
                end
                for i,v in pairs(player.room.holding) do
                    if obj == v then
                        item = v
                    end
                end
                if item then
                    if items[item].desc then
                        print(items[item].desc)
                    else
                        print("It's just a regular old " .. items[item].name .. ".")
                    end
                else
                    print("You don't see any " .. items[obj].name .. " here.")
                end
            end
        },
        read = {
            handler = function(verb, obj, hook)
                if hook then
                    hook()
                else
                    print("You can't read that.")
                end
            end
        }
    }
    return verbs
end

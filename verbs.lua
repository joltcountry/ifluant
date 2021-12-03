function itemMatches(item, str)
    for i,v in pairs(item.names) do
        if (v == str) then return true end
    end
    return false
end

function dirHandler(gamestate, v)
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
            handler = function(gamestate)
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
                        print("   "..article(v).." " .. v.name)
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
            handler = function(gamestate, verb, adj, obj)
                if player.room.holding then
                    for i,v in pairs(player.room.holding) do
                        if itemMatches(v, obj) then
                            print('You pick up the '..v.name..'.')
                            moveItem(v, player.room, player)
                            return
                        end
                    end
                end
                print("You don't see any " .. obj .. " here.")
            end
        },
        drop = {
            handler = function(gamestate, verb, adj, obj)
                for i,v in pairs(player.holding) do
                    if itemMatches(v, obj) then
                        print('You drop the '..v.name..'.')
                        moveItem(v, player, player.room)
                        return
                    end
                end
                print("You're not carrying any " .. obj .. ".")
            end
        },
        examine = {
            synonyms = { 'x' },
            handler = function(gamestate, verb, adj, obj)
                local item
                for i,v in pairs(player.holding) do
                    if itemMatches(v, obj) then
                        item = v
                    end
                end
                for i,v in pairs(player.room.holding) do
                    if itemMatches(v, obj) then
                        item = v
                    end
                end
                if item then
                    if item.desc then
                        print(item.desc)
                    else
                        print("It's just a regular old " .. item.name .. ".")
                    end
                else
                    print("You don't see any " .. obj .. " here.")
                end
            end

        }
    }
    return verbs
end

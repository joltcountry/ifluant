-- The ifluant Interactive Fiction engine
--
-- For question/criticisms, email bparrish99@gmail.com

Ifluant = {}

player = {
    holding = {}
}

gamestate = {
    quit = false
}

rooms = {}
items = {}

require 'ifluant-utils'
require 'verbs'

function Ifluant:new()

    local verbs = initVerbs()

    local function parse(line)
        tokens={}
        for token in string.gmatch(line, "[^%s]+") do
            table.insert(tokens, token)
        end
        -- verb, adj, obj, xadj, xobj
        return tokens[1], nil, tokens[2], nil, nil
    end

    local self = {}

    function self.item(k, v)

        v.actions = v.actions or {}
        items[k] = v 
    
    end
    
    function self.room(k, v)

        v.actions = v.actions or {}
        v.lighted = true
        v.holding = v.holding or {}
        rooms[k] = v
    
    end
    
    function self.run()

        repeat
            ::continue::

            if player.moved then
                print(bold(player.room.shortdesc))
                if not player.room.seen then
                    showRoom(player.room)
                    player.room.seen = true
                end
                showRoomContents(player.room)
                player.moved = false
            end

            io.write('\n> ')

            line = io.read()
            
            local verb, adj, obj, xadj, xobj = parse(line)

            if not verb then
                print('Say what now?')
                goto continue
            end

            local recognized = false

            for i, v in pairs(verbs) do
                
                if (verb == i) then
                    recognized = true
                elseif v.synonyms then
                    for si,sv in pairs(v.synonyms) do
                        if (verb == sv) then
                            recognized = true
                        end
                    end
                end
                
                if recognized then
                    -- run hook on anything present
                    local shortcut = false
                    local overrideText = false
                    
                    local objKey = findObject(obj)

                    if (objKey and items[objKey].actions[i]) then
                        shortcut, overrideText = items[objKey].actions[i](adj, obj, xadj, xobj)
                    end

                    if not shortcut then
                        v.handler(i, adj, obj, xadj, xobj, overrideText)
                    end

                    break
                end
            
            end

            if not recognized then
                print("I don't understand \"" .. verb .. "\".")
            end

        until gamestate.quit

    end

    return self;

end
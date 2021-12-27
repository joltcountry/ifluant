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

require 'ifluant.ifluant-utils'
require 'ifluant.verbs'
require 'ifluant.parser'

function Ifluant:new()

    local verbs = initVerbs()
    local parser = Parser:new();

    local self = {}

    function self.item(k, v)

        v.actions = v.actions or {}
        items[k] = v 
    
    end
    
    function self.room(k, v)

        v.actions = v.actions or {}
        v.holding = v.holding or {}
        rooms[k] = v
    
    end
    
    function self.turn(line)

        if line then

            local verb, obj = parser:parse(line)

            if not verb then
                print('Say what now?')
                goto done
            end

            if obj then
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
                if not item then
                    print("You don't see that here.")
                    goto done
                end
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
                    local hook

                    if (obj and items[obj].actions[i]) then
                        hook = items[obj].actions[i]
                    end

                    v.handler(i, obj, hook)

                    break
                end
            
            end

            if not recognized then
                print("I don't understand \"" .. verb .. "\".")
            end
        end

        if player.moved then
            print(player.room.shortdesc)
            if not player.room.seen then
                showRoom(player.room)
                if isLit(player.room) then
                    player.room.seen = true
                end
            end
            showRoomContents(player.room)
            player.moved = false
        end

        ::done::

        print('')
    end

    return self;

end
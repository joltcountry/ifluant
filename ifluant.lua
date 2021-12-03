-- The ifluant Interactive Fiction engine
--
-- For question/criticisms, email bparrish99@gmail.com

ifluant = {}
player = {}

local quit = false

function bold(s)
    io.write('\27[1m'..s..'\27[0m')
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

function ifluant.run()

    repeat

        if player.moved then
            print(bold(player.room.shortdesc))
            if not player.room.seen then
                print(player.room.desc)
                player.room.seen = true
            end
            player.moved = false
        end

        io.write('\n> ')

        line = io.read()
        if (line == 'q' or line == 'quit') then
            quit = true
        elseif (line == 'l' or line == 'look') then
            print(bold(player.room.shortdesc))
            print(player.room.desc)
        elseif (line == 'n' or line == 's' or line == 'e' or line == 'w') then
            dest = player.room.dirs[line]
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
        else
            print("I don't understand the command \"" .. line .. "\".")
        end

    until quit

end

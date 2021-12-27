-- Lua Caves
--
-- Arguably the greatest, most scintillating three-room cave exploration game ever written in Lua

require 'lib.lovesheet'
require 'lib.loveconsole'
require 'ifluant.ifluant'       -- Loads the game engine (required as first line)

ifluant = Ifluant:new()

require 'items'         -- Items!
require 'rooms'         -- Defines the rooms in your game

oldprint = print
print = function (s) sheet:print(s) end

-- Initialize engine
function love.load()
    love.window.setMode(600, 600)
    sheet = Sheet:new(0, 0, 600, 24)
    console = Console:new(10, 560, 500, '>')
    -- Introductory text and stuff
    sheet:print("Welcome to the Lua Caves!")
    sheet:print("")
    sheet:print("This is an exciting, fun adventure for the whole family.")
    sheet:print("(Written in ifluant v0.0000001 by Ben Parrish, Copyright (c) 2021 Jolt Country Games)")
    sheet:print("")
    -- Set up some flags for game logic
    gamestate.foundsecret = 0

    -- Set the player's initial location
    player.moveTo(rooms.outside)
    giveItem('authornote', player)
    ifluant.turn()
end

function love.draw()
    sheet:draw()
    console:draw()
end

function love.update(dt)
    console:update(dt)
end

function love.keypressed(key)
    local cmd = console:handleKey(key)
    if cmd then 
        ifluant.turn(cmd)
        if gamestate.quit then
            love.event.quit()
        end
    end
end

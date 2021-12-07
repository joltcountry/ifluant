-- Lua Caves
--
-- Arguably the greatest, most scintillating three-room cave exploration game ever written in Lua

require 'ifluant'       -- Loads the game engine (required as first line)

ifluant = Ifluant:new()

require 'items'         -- Items!
require 'rooms'         -- Defines the rooms in your game

-- Initialize engine

-- Set up some flags for game logic
gamestate.foundsecret = 0

-- Set the player's initial location
player.moveTo(rooms.outside)
giveItem('authornote', player)

-- Introductory text and stuff
print "Welcome to the Lua Caves!"
print ""
print "This is an exciting, fun adventure for the whole family."
print "(Written in ifluant v0.0000001 by Ben Parrish, Copyright (c) 2021 Jolt Country Games)"
print ""
say "Commands: n, e, w, s, l, x/example, get, drop, light, open, close, q to quit"

-- Run the whole goddamn game
ifluant.run();

say "Well, thanks for enjoying the caves.  Have a nice day, and Baba Booey to y'all."
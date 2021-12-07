-- Here is where you define your rooms.
-- 
-- Rooms have a few standard attributes that must be defined for the engine to work properly:
--
-- shortdesc: Short description of the room (like you'd see when you move to a room)
-- desc: Long description (like you'd see when you FIRST move to a room, or type "look"
-- dirs: List of cardinal directions and what happens when you try to go there.
--   - If the value of a direction is a string, it will just print that and not move the player.
--   - If the value is a function, and the function returns a room, it will move the player there.
--   - If the value is a function, and does NOT return a room, it will not move the player.
--   - If a direction is not specified, it will output a generic "you can't go there" message.
--
-- More to come!

ifluant.room('office', {
    shortdesc = "In your office",
    desc = [[ This is your office.  It's practically your office.  Why you decided to put your office right next to a cave opening, only you know!  You can hang out here or go back to the cave to the east. ]],
    dirs = {
        e = function()
            if (items['mydoor'].open) then
                return rooms.outside
            else
                print "A large wooden door blocks your way."
            end
        end
    },
    lighted = true,
    holding = {
        'mydoor'
    }
})

ifluant.room('outside', {
    shortdesc = "Outside the cave",
    desc = [[ You stand outside the entrance to a cave, which leads down to the north.  What's in there, and how far down it goes, nobody knows.  The door to your office lies west. ]],
    dirs = {
        n = go('inside'),
        e = "This is really more of a north/south kinda game.",
        w = function()
            if (items['mydoor'].open) then
                return rooms.office
            else
                print "A large wooden door blocks your way."
            end
        end
    },
    holding = {
        'lantern',
        'mydoor'
    },
    lighted = true
})

ifluant.room('inside', {
    shortdesc = "Inside the cave",
    desc = "Welp, here you are in the cave.  Adventure over!",
    dirs = {
        s = go('outside'),
        e = function ()
                if gamestate.foundsecret > 0 then
                    if (gamestate.foundsecret == 1) then
                        say "You found the secret!"
                        gamestate.foundsecret = 2
                    end
                    return rooms.secret
                else
                    print "You can't go that way... yet."
                    gamestate.foundsecret = 1
                end
            end,
        n = "This cave isn't very deep, sorry."
    },
    holding = {
        'rock'
    },
    lighted = false
})

ifluant.room('secret', {
    shortdesc = "The Room of Secrets",
    desc = "Oh man, this is totally the secret room!  You must be some kind of spelunking genius!",
    dirs = {
        w = function ()
                if (not gamestate.leftsecret) then 
                    say "Well, I mean, if you really wanna leave this awesome secret area..."
                    gamestate.leftsecret = true
                end
                return rooms.inside
            end,
        e = "Sorry, this is REALLY the end of the road.",
        n = "Sorry, this is REALLY the end of the road.",
        s = "Sorry, this is REALLY the end of the road.",
    }
})

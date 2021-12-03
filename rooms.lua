rooms = {

    outside = {
        shortdesc = "Outside the cave",
        desc = "You stand outside the entrance to a cave, which leads down to the north.  What's in there, and how far down it goes, nobody knows.",
        dirs = {
            n = go('inside'),
            e = "This is really more of a north/south kinda game.",
            w = "This is really more of a north/south kinda game."
        }
    },

    inside = {
        shortdesc = "Inside the cave",
        desc = "Welp, here you are in the cave.  Adventure over!",
        dirs = {
            s = go('outside'),
            e = function ()
                    if flags.foundsecret > 0 then
                        if (flags.foundsecret == 1) then
                            say "You found the secret!"
                            flags.foundsecret = 2
                        end
                        return rooms.secret
                    else
                        print "You can't go that way... yet."
                        flags.foundsecret = 1
                    end
                end,
            n = "This cave isn't very deep, sorry."
        }
    },

    secret = {
        shortdesc = "The Room of Secrets",
        desc = "Oh man, this is totally the secret room!  You must be some kind of spelunking genius!",
        dirs = {
            w = function ()
                    if (not flags.leftsecret) then 
                        say "Well, I mean, if you really wanna leave this awesome secret area..."
                        flags.leftsecret = true
                    end
                    return rooms.inside
                end,
            e = "Sorry, this is REALLY the end of the road.",
            n = "Sorry, this is REALLY the end of the road.",
            s = "Sorry, this is REALLY the end of the road.",
        }
    }

}
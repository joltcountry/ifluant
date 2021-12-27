ifluant.item('lantern', {
    name = "old rusty lantern",
    article = "an",
    names = { "lantern", "lamp" },
    desc = function(this)
        io.write("A well-worn copper lantern, just ripe for lighting and carrying, once I implement that.  It is currently ")
        if this.giveslight then
            print("lit.")
        else
            print("not lit.")
        end
    end,

    actions = {
        drop = describe("Though you sense it's against your better judgment, you drop the damn lantern."),
        light = function(this)
            if this.giveslight then
                print("The lantern is already lit, giving off warm, comfortable beams of illumination.")
            else
                this.giveslight = true
                print("You light the lantern.  How you did that is not terribly clear, but just go with it.")
            end
        end
    },
})

ifluant.item('authornote', {
    name = "note from the author",
    names = { "note" },
    desc = "A special note from the author, just for you, which you can read once I implement reading.",
    actions = {
        read = perform("It reads...\n\nThanks for playing Lua Caves!  Remember, if you find something you don't know how to do, look it up on Google!")
    }
})

ifluant.item('rock', {
    name = "rock",
    names = { "rock", "stone" },
    actions = {
        drop = function()
            print("It was a cursed rock, you can't drop it!")
            return true
        end
    }
})

ifluant.item('mydoor', {
    name = "mydoor",
    names = { "door" },
    desc = function(this)
        io.write("A worn birch door, which hopefully you can open and close.  It is currently ")
        if this.open then
            print("open.")
        else
            print("closed.")
        end
    end,

    actions = {
        open = function(this)
            if not this.open then
                this.open = true
                print("The door opens with a slight creak, as text adventure doors are wont to do.")
                return true
            else
                print("It's already open.")
            end
        end,
        close = function(this)
            if this.open then
                this.open = false
                print("You slam the door closed, angrily.  Calm down, sir.")
                return true
            else
                print("It's already closed.")
            end
        end
    },
    hidden = true,
    fixed = true
})
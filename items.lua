lantern = {
    name = "old rusty lantern",
    article = "an",
    names = { "lantern", "lamp" },
    desc = "A well-worn copper lantern, just ripe for lighting and carrying, once I implement that.",
    hooks = {
        drop = function()
            say("After considering it for a few moments...")
        end
    }
}

authornote = {
    name = "note from the author",
    names = { "note" },
    desc = "A special note from the author, just for you, which you can read once I implement reading."
}

rock = {
    name = "rock",
    names = { "rock", "stone" },
    hooks = {
        drop = function()
            print("It was a cursed rock, you can't drop anything!")
            return true
        end
    }
}
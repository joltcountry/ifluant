ifluant.item('lantern', {
    name = "old rusty lantern",
    article = "an",
    names = { "lantern", "lamp" },
    desc = "A well-worn copper lantern, just ripe for lighting and carrying, once I implement that.",
    actions = {
        drop = describe("Though you sense it's against your better judgment, you drop the damn lantern.")
    },
    giveslight = true
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

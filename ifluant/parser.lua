Parser = {}

function Parser:new()
    local articles = { "a", "an", "the" }
    local self = {}
    function self:parse(line)
        tokens={}
        for token in string.gmatch(line, "[^%s]+") do
            table.insert(tokens, token)
        end
        -- verb, adj, obj, xadj, xobj
        local obj = findObject(tokens[2])
        return tokens[1], obj
    end
    return self
end
    
    
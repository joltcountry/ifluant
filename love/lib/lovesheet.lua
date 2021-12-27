Sheet = {}

font = love.graphics.newFont(18);

function Sheet:addLine(s)
    self.lines[#self.lines + 1] = str
    if (#self.lines > self.topline + self.lineheight - 1) then
        self.topline = self.topline + 1
    end
end

function Sheet:new(x, y, width, lineheight)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.x = x or 0
    o.y = y or 0
    o.width = width or love.graphics.getWidth()
    o.lineheight = lineheight or 40
    o.lines = {}
    o.topline = 1
    o.margin = 10
    return o
end

function Sheet:print(s)
    str = ""
    s = s:gsub('\n', ' :newline: ')
    s = s:gsub('\t', ' :tab: ')
    for word in s:gmatch('%S+') do
        if (word == ':newline:') then
            self:addLine(str)
            str = ""
        elseif word == ':tab:' then
            str = str .. string.rep(" ", 4)
        elseif font:getWidth(str .. ' ' .. word) > self.width - self.margin * 2 then
            self:addLine(str)
            str = word
        else
            if (#str > 0) then
                str = str .. ' '
            end
            str = str .. word
            if str:sub(#str, #str) == '.' then
                str = str .. ' '
            end
        end
    end
    self:addLine(str)
end

function Sheet:draw()
    love.graphics.setColor(.8,.8,1)
    love.graphics.setFont(font)

    love.graphics.rectangle('line', self.x, self.y, self.width, font:getHeight('X') * self.lineheight + (self.margin * 2))
    for i = 1, self.lineheight do
        if self.lines[self.topline + i - 1] then
            love.graphics.print(self.lines[self.topline + i - 1], self.x + self.margin, self.y + self.margin + (i-1) * font:getHeight(v))
        end
    end
end
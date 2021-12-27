Console = {}

font = love.graphics.newFont(18);

function Console:new(x, y, width, prompt)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.prompt = prompt
    o.x = x or 0
    o.y = y or 0
    o.width = width or love.graphics.getWidth()
    o.cmd = ""
    o.blinktimer = 0
    o.blink = true
    return o
end

function Console:handleKey(k)
    if #k == 1 then
        self.cmd = self.cmd .. k
    elseif k == 'space' then
        self.cmd = self.cmd .. ' '
    elseif k == 'backspace' then
        self.cmd = string.sub(self.cmd, 1, #self.cmd - 1)
    elseif k == 'return' then
        local final = self.cmd
        self.cmd = ""
        return final
    end
end

function Console:update(dt)
    self.blinktimer = self.blinktimer + dt
    if self.blinktimer > 1 then
        self.blink = true
        self.blinktimer = self.blinktimer % 1
    end
    if self.blinktimer > .5 then self.blink = false end
end

function Console:draw()
    love.graphics.setColor(.8,.8,1)
    love.graphics.setFont(font)
    local startX = self.x
    if (self.prompt) then
        local promptStr = self.prompt .. ' '
        love.graphics.print(promptStr, startX, self.y)
        startX = startX + font:getWidth(promptStr)
    end
    love.graphics.print(self.cmd, startX, self.y)
    if self.blink then
        love.graphics.setColor(0, 1, 0)
        love.graphics.line(startX + font:getWidth(self.cmd), self.y + font:getHeight(self.cmd), startX + font:getWidth(self.cmd) + font:getWidth('a'), self.y + font:getHeight(self.cmd))
    end
end
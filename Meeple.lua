Meeple = Class{}

function Meeple:init(i, j, est_blanc)
    self.i = i
    self.j = j
    self.est_blanc = est_blanc
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.emoji = '?'
end

-- TODO: move to Plateau:draw()
function Meeple:draw()
    love.graphics.print(self.emoji, self.i * 10, self.j * 10, 0, 10, 10)
end

-- vérifie uniquement que l'on sort pas du plateau
function Meeple:mouvement_legal(new_i, new_j)
    if new_i < 1 or new_i > 8 or new_j < 1 or new_j > 8 then
        return false
    else
        return true
    end
end

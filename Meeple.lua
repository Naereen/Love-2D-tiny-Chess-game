Meeple = Class{}

function Meeple:init(i, j, est_blanc)
    self.i = i
    self.j = j
    self.est_blanc = est_blanc
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.emoji = '?'
end

-- TODO: move to Plateau:draw() ?
function Meeple:draw()
    love.graphics.print(self.emoji, self.i * SCALE_FACTOR, self.j * SCALE_FACTOR, 0, SCALE_FACTOR, SCALE_FACTOR)
end

-- vérifie uniquement que l'on sort pas du plateau
function Meeple:mouvement_legal(new_i, new_j)
    if new_i < 1 or new_i > 8 or new_j < 1 or new_j > 8 then
        return false
    else
        return true
    end
end

-- déplace le Meeple actuel à cette nouvelle case
function Meeple:deplace(new_i, new_j)
    self.i = new_i
    self.j = new_j
end
Meeple = Class{}

function Meeple:init(i, j, est_blanc, est_vide)
    self.i = i
    self.j = j
    self.est_blanc = est_blanc
    self.est_vide = est_vide
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.emoji = '?'
end

-- TODO: move to Plateau:draw() ?
function Meeple:draw()
    love.graphics.print(self.emoji, self.i * SCALE_FACTOR, self.j * SCALE_FACTOR, 0, SCALE_FACTOR, SCALE_FACTOR)
end

-- vérifie uniquement que l'on sort pas du plateau, et que l'on arrive pas sur une case ayant un Meeple de la même couleur
function Meeple:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    -- si on ne se déplace pas, mouvement illégal
    if new_i == self.i and new_j == self.j then
        return false
    end
    -- si on sort du plateau, mouvement illégal
    if new_i < 1 or new_i > 8 or new_j < 1 or new_j > 8 then
        return false
    end
    -- si on arrive sur un Meeple de notre couleur, on peut pas s'y déplacer
    if case_arrivee.est_blanc == self.est_blanc then
        return false
    end
    -- si on arrive sur un Meeple adverse, ou un vide, c'est bon on peut s'y déplacer
    return true
end

-- déplace le Meeple actuel à cette nouvelle case
function Meeple:deplace(new_i, new_j)
    -- TODO: il faut s'assurer de créer un Vide(i, j) dans le plateau
    -- TODO: et de déplacer le Meeple dans le plateau
    self.i = new_i
    self.j = new_j
end
Piece = Class{}

function Piece:init(i, j, est_blanc, est_vide)
    self.i = i
    self.j = j
    self.est_blanc = est_blanc
    self.est_vide = est_vide
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.emoji = '?'
end

-- Dessiner la pièce
function Piece:draw()
    love.graphics.print(self.emoji, (self.i + 0.125) * SCALE_FACTOR, (self.j + 0.125) * SCALE_FACTOR, 0, 2, 2)
end

-- vérifie uniquement que l'on sort pas du plateau, et que l'on arrive pas sur une case ayant un Piece de la même couleur
function Piece:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    -- si on ne se déplace pas, mouvement illégal
    if new_i == self.i and new_j == self.j then
        return false
    end
    -- si on sort du plateau, mouvement illégal
    if new_i < 1 or new_i > 8 or new_j < 1 or new_j > 8 then
        return false
    end
    -- si on arrive sur un Piece de notre couleur, on peut pas s'y déplacer
    if case_arrivee.est_blanc == self.est_blanc then
        return false
    end
    -- si on arrive sur un Piece adverse, ou un vide, c'est bon on peut s'y déplacer
    return true
end

-- déplace le Piece actuel à cette nouvelle case
function Piece:deplace(new_i, new_j)
    assert(1 <= new_i and new_i <= 8)
    assert(1 <= new_j and new_j <= 8)
    -- DONE il faut s'assurer de créer un Vide(i, j) dans le plateau
    -- DONE et de déplacer le Piece dans le plateau
    self.i = new_i
    self.j = new_j
end
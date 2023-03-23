Pion = Class{__includes = Piece}

function Pion:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♙'
    else
        self.emoji = '♟'
    end
end

function Pion:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    local piece = Piece(self.i, self.j, self.est_blanc)
    if piece:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    -- si == -1 ou == +1 il faut vérifier que la case d'arrivée est de la couleur adverse
    if (self.i == new_i - 1 or self.i == new_i + 1) and case_arrivee.est_vide then
        return false
    end
    if self.est_blanc then
        -- cas spécial du premier coup du pion
        if self.j == 7 and new_i == self.i and new_j == 5 then
            return true
        end
        return (new_j == self.j - 1) and (self.i == new_i or self.i == new_i - 1 or self.i == new_i + 1)
    else
        -- cas spécial du premier coup du pion
        if self.j == 2 and new_i == self.i and new_j == 4 then
            return true
        end
        return (new_j == self.j + 1) and (self.i == new_i or self.i == new_i - 1 or self.i == new_i + 1)
    end
end

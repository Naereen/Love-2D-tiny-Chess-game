Roi = Class{__includes = Piece}

function Roi:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♔'
    else
        self.emoji = '♚'
    end
end

function abs(x)
    if x < 0 then return (-1 * x) else return x end
end

function Roi:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    local piece = Piece(self.i, self.j, self.est_blanc)
    if piece:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    -- mouvement légal si on a un déplacement que de 0/+-1 ou +-1/0 ou +-1/+-1
    if (new_i == self.i and abs(new_j - self.j) == 1) or (new_j == self.j and abs(new_i - self.i) == 1) or (abs(new_j - self.j) == 1 and abs(new_i - self.i) == 1) then
        return true
    else
        return false
    end
end

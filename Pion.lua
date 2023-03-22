Pion = Class{__includes = Meeple}

function Pion:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♙'
    else
        self.emoji = '♟︎'
    end
end

function Pion:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    if Meeple:mouvement_legal(new_i, new_j, case_arrivee) == false then -- si on sort du plateau
        return false -- mouvement illégal
    end
    if self.est_blanc then
        return ((self.i == 7 and (new_i == 6 or new_i == 5)) or (new_i == self.i - 1)) and (self.j == new_j or self.j == new_j - 1 or self.j == new_j + 1)
    else
        return ((self.i == 2 and (new_i == 3 or new_i == 4)) or (new_i == self.i + 1)) and (self.j == new_j or self.j == new_j - 1 or self.j == new_j + 1)
    end
end

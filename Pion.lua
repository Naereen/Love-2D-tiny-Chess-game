require 'Meeple'
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
        self.emoji = '♟'
    end
end

function Pion:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    if Meeple:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    if self.est_blanc then
        return ((self.j == 7 and (new_j == 6 or new_j == 5)) or (new_j == self.j - 1)) and (self.i == new_i or self.i == new_i - 1 or self.i == new_i + 1)
    else
        return ((self.j == 2 and (new_j == 3 or new_j == 4)) or (new_j == self.j + 1)) and (self.i == new_i or self.i == new_i - 1 or self.i == new_i + 1)
    end
end

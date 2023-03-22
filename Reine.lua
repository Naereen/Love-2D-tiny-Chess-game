Reine = Class{__includes = Meeple}

function Reine:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♕'
    else
        self.emoji = '♛'
    end
end

function Reine:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    if Meeple:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    return Tour:mouvement_legal(new_i, new_j, case_arrivee, plateau) or Fou:mouvement_legal(new_i, new_j, case_arrivee, plateau)
end

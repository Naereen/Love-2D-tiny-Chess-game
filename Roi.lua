Roi = Class{__includes = Meeple}

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

function Roi:mouvement_legal(new_i, new_j, case_arrivee)
    if Meeple:mouvement_legal(new_i, new_j, case_arrivee) == false then -- si on sort du plateau
        return false -- mouvement illégal
    end
    return true -- TODO:
end

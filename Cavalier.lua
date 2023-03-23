Cavalier = Class{__includes = Piece}

function Cavalier:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♘'
    else
        self.emoji = '♞'
    end
end

function Cavalier:mouvement_legal(new_i, new_j, case_arrivee)
    if Piece:mouvement_legal(new_i, new_j, case_arrivee) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    local delta_i = new_i - self.i
    local delta_j = new_j - self.j
    if     (delta_i == -1 and delta_j == -2)
        or (delta_i == 1 and delta_j == -2)
        or (delta_i == -1 and delta_j == 2)
        or (delta_i == 1 and delta_j == 2)
        or (delta_i == -2 and delta_j == -1)
        or (delta_i == 2 and delta_j == -1)
        or (delta_i == -2 and delta_j == 1)
        or (delta_i == 2 and delta_j == 1)
    then
        return true
    end
    return false
end

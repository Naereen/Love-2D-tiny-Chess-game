Reine = Class{__includes = Piece}

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
    local piece = Piece(self.i, self.j, self.est_blanc)
    if piece:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    local une_tour = Tour(self.i, self.j, self.est_blanc)
    local un_fou = Fou(self.i, self.j, self.est_blanc)
    return une_tour:mouvement_legal(new_i, new_j, case_arrivee, plateau) or un_fou:mouvement_legal(new_i, new_j, case_arrivee, plateau)
end

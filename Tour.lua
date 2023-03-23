Tour = Class{__includes = Piece}

function Tour:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♖'
    else
        self.emoji = '♜'
    end
end

-- Minimum de deux valeurs
function min(a, b)
    if a < b then return a else return b end
end

-- Maximum de deux valeurs
function max(a, b)
    if a < b then return b else return a end
end

function Tour:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    local piece = Piece(self.i, self.j, self.est_blanc)
    if piece:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    if (new_i == self.i and new_j ~= self.j) then
        -- mouvement purement vertical
        for inter_j = min(new_j, self.j) + 1, max(new_j, self.j) - 1 do
            -- si on tombe sur une case occupée, c'est fichu
            if plateau.matrix[self.i][inter_j].est_vide == false then
                return false
            end
        end
        return true
    end
    if (new_i ~= self.i and new_j == self.j) then
        -- mouvement purement horizontal
        for inter_i = min(new_i, self.i) + 1, max(new_i, self.i) - 1 do
            -- si on tombe sur une case occupée, c'est fichu
            if plateau.matrix[inter_i][self.j].est_vide == false then
                return false
            end
        end
        return true
    end
    return false
end

Tour = Class{__includes = Meeple}

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

function Tour:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    if Meeple:mouvement_legal(new_i, new_j, case_arrivee) == false then -- si on sort du plateau
        return false -- mouvement illégal
    end
    if (new_i == self.i and new_j ~= self.j) then
        -- mouvement purement vertical
        for inter_j = min(new_j, self.j) + 1, max(new_j, self.j) - 1 do
            -- si on tombe sur une case occupée, c'est fichue
            if plateau.matrix[self.i][inter_j].est_vide == false then
                return false
            end
        end
    end
    if (new_i ~= self.i and new_j == self.j) then
        -- mouvement purement horizontal
        for inter_i = min(new_i, self.i) + 1, max(new_i, self.i) - 1 do
            -- si on tombe sur une case occupée, c'est fichue
            if plateau.matrix[inter_i][self.j].est_vide == false then
                return false
            end
        end
    end
    return false
end

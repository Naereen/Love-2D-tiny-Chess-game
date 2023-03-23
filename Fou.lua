Fou = Class{__includes = Piece}

function Fou:init(i, j, est_blanc)
    self.est_vide = false
    self.i = i
    self.j = j
    -- https://en.wikipedia.org/wiki/Chess_symbols_in_Unicode
    self.est_blanc = est_blanc
    if est_blanc then
        self.emoji = '♗'
    else
        self.emoji = '♝'
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

-- Valeur absolue
function abs(x)
    if x < 0 then return (-1 * x) else return x end
end

function signe(x)
    if x < 0 then return (-1) else return 1 end
end

function Fou:mouvement_legal(new_i, new_j, case_arrivee, plateau)
    if Piece:mouvement_legal(new_i, new_j, case_arrivee, plateau) == false then -- si trivialement illégal
        return false -- mouvement illégal
    end
    -- pour la tour : marche si delta_x == 0 et delta_y != 0 et Vide sur la verticale, ou l'inverse avec l'horizontale
    -- pour le Fou : marche si delta_x == delta_y et que des Vide sur la diagonale
    if (abs(new_i - self.i) == abs(new_j - self.j)) then
        -- mouvement sur la diagonale
        -- TODO: mieux calculer les indices, et directions de la diagonale ?
        local direction_i = signe(new_i - self.i)
        local direction_j = signe(new_j - self.j)
        for delta = min(min(new_i, self.i), min(new_j, self.j)) + 1, min(max(new_i, self.i), max(new_j, self.j)) - 1 do
            -- si on tombe sur une case occupée, c'est fichue
            if self.i + direction_i * delta >= 1 and self.i + direction_i * delta <= 8 and self.j + direction_j * delta >= 1 and self.j + direction_j * delta <= 8 and plateau.matrix[self.i + direction_i * delta][self.j + direction_j * delta].est_vide == false then
                return false
            end
        end
        return true
    end
    return false
end

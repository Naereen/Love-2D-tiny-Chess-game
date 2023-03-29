Plateau = Class{}

-- Création du plateau initial
function Plateau:init()
    self.matrix = {}
    for i = 1,8 do
        self.matrix[i] = {}
        for j = 1,8 do
            self.matrix[i][j] = Vide(i, j)
        end
    end
    for i = 1,8 do
        self.matrix[i][2] = Pion(i, 2, false)
        self.matrix[i][7] = Pion(i, 7, true)
    end
    -- les pièces noires
    self.matrix[1][1] = Tour(1, 1, false)
    self.matrix[2][1] = Cavalier(2, 1, false)
    self.matrix[3][1] = Fou(3, 1, false)
    self.matrix[4][1] = Reine(4, 1, false)
    self.matrix[5][1] = Roi(5, 1, false)
    self.matrix[6][1] = Fou(6, 1, false)
    self.matrix[7][1] = Cavalier(7, 1, false)
    self.matrix[8][1] = Tour(8, 1, false)

    -- TODO: enlever ces pièces au centre, mise là pour débogguer
    -- self.matrix[4][4] = Tour(4, 4, false)
    -- self.matrix[5][5] = Tour(5, 5, true)

    -- les pièces blanches
    self.matrix[1][8] = Tour(1, 8, true)
    self.matrix[2][8] = Cavalier(2, 8, true)
    self.matrix[3][8] = Fou(3, 8, true)
    self.matrix[4][8] = Reine(4, 8, true)
    self.matrix[5][8] = Roi(5, 8, true)
    self.matrix[6][8] = Fou(6, 8, true)
    self.matrix[7][8] = Cavalier(7, 8, true)
    self.matrix[8][8] = Tour(8, 8, true)
end

-- table mappant A..H à 1..9
lettres = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'}

-- pour dessiner le Plateau
function Plateau:draw()
    local parite = 0
    for j = 1,8 do
        love.graphics.print(tostring(9-j), 0.5*SCALE_FACTOR, (j + 0.25)*SCALE_FACTOR)
        love.graphics.print(lettres[j], (j + 0.4)*SCALE_FACTOR, 0.65*SCALE_FACTOR, 0, 0.65, 0.65)
    end
    for i = 1,8 do
        parite = (parite + 1) % 2
        for j = 1,8 do
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, (i+1)*SCALE_FACTOR, j*SCALE_FACTOR)
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, i*SCALE_FACTOR, (j+1)*SCALE_FACTOR)

            -- dessiner des carrés noir/blanc en alternance un sur deux
            parite = (parite + 1) % 2
            if i <= 8 and j <= 8 then
                if parite == 0 then
                    love.graphics.setColor(0.6, 0.6, 0.6, 1.0)  -- gris foncé
                else
                    love.graphics.setColor(0, 0, 0, 1.0)  -- noir
                end
                love.graphics.rectangle('fill', i*SCALE_FACTOR, j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
                love.graphics.setColor(1, 1, 1, 1)  -- blanc pour les lignes
            end

            local piece = self.matrix[i][j]
            piece:draw()
        end
    end
    love.graphics.line(SCALE_FACTOR*9, SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9)
    love.graphics.line(SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9, SCALE_FACTOR*9)

    -- on surligne de jaune la case actuellement sélectionnée par la souris ?
    if mouse_i >= 1 and mouse_i <= 8 and mouse_j >= 1 and mouse_j <= 8 then
        love.graphics.setColor(1, 1, 0, 0.5)
        love.graphics.rectangle('fill', mouse_i*SCALE_FACTOR, mouse_j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
        love.graphics.setColor(1, 1, 1, 1)
    end

    -- on surligne de vert la pièce actuellement sélectionnée à la souris ?
    if piece_selectionnee ~= nil then
        local p_i = piece_selectionnee.i
        local p_j = piece_selectionnee.j
        love.graphics.setColor(0, 1, 0, 0.5)
        love.graphics.rectangle('fill', p_i*SCALE_FACTOR, p_j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
        love.graphics.setColor(1, 1, 1, 1)
    end

    -- maintenant, si la pièce sélectionnée est surlignée en vert, pour chaque case sur laquelle elle peut aller, on la surligne en bleu clair
    if piece_selectionnee ~= nil then
        for i = 1,8 do
            for j = 1,8 do
                if piece_selectionnee:mouvement_legal(i, j, plateau.matrix[i][j], plateau) then
                    love.graphics.setColor(0, 0, 1, 0.5)
                    love.graphics.rectangle('fill', i*SCALE_FACTOR, j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        end
    end
end

-- pour déplacer une pièce, et implémenter la logique d'alternance joueur blanc, joueur noir, et la fin de jeu en cas de prise d'un Roi
function Plateau:deplace(i, j, new_i, new_j)

    local piece_arrivee = plateau.matrix[new_i][new_j]
    -- si piece_arrivee n'est pas vide, on peut faire 1) assert couleur différente 2) marquer un point au joueur actuel
    local couleur_piece_arrivee = piece_arrivee.est_blanc

    -- est-ce que la pièce d'arrivée est un roi ?
    local piece_arrivee_est_roi = piece_arrivee.est_roi

    -- mouvement classique, vers une case vide, rien à faire
    if couleur_piece_arrivee == nil then
        print(string.format("Mouvement classique (%d,%d) vers une case vide (%d,%d), rien de spécial à faire.", i, j, new_i, new_j))
    else
        local couleur_piece_depart = plateau.matrix[i][j].est_blanc
        -- n'arrive jamais, on a bien vérifié ça avant
        assert(couleur_piece_arrivee ~= couleur_piece_depart, "Erreur : pièce de départ en " .. i .. "," .. j .. "doit avoir une couleur différente de la case d'arrivée en " .. new_i .. "," .. new_j)
        print(string.format("Mouvement offensif légal de (%d,%d) vers une case non vide (%d,%d), on a vérifié la couleur d'arrivée.", i, j, new_i, new_j))
    end
    -- si la case d'arrivée n'est pas vide, on doit marquer un point au joueur actuel
    if couleur_piece_arrivee ~= nil then
        joueur_actif:marque_un_point()
    end
    -- on délègue le déplacement à la méthode Piece:deplace(...)
    plateau.matrix[i][j]:deplace(new_i, new_j)
    -- on a vidé la case (i,j) c'est bon
    plateau.matrix[new_i][new_j] = plateau.matrix[i][j]
    plateau.matrix[i][j] = Vide(i, j)

    -- si la pièce d'arrivée était un roi
    if piece_arrivee_est_roi then
        -- TODO: quitter joliment, avec un message à l'écran, j'ai la flemme
        joueur_actif:message_a_gagne()
        jeu_fini = true
        -- on quitte dans 5 secondes
        love.timer.sleep(5)
        love.event.quit()
    end

    -- réinitialise la pièce sélectionnée
    piece_selectionnee = nil

    -- alternance joueur blanc, joueur noir, à l'infini
    if joueur_actif == joueur_blanc then
        joueur_actif = joueur_noir
    else
        joueur_actif = joueur_blanc
    end
end
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

    -- une pièce au centre pour débogguer
    self.matrix[4][4] = Pion(4, 4, false)
    self.matrix[5][5] = Pion(5, 5, true)

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

-- pour dessiner le Plateau
function Plateau:draw()
    parite = 0
    for i = 1,8 do
        parite = (parite + 1) % 2
        for j = 1,8 do
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, (i+1)*SCALE_FACTOR, j*SCALE_FACTOR)
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, i*SCALE_FACTOR, (j+1)*SCALE_FACTOR)

            -- dessiner des carrés noir/blanc en alternance un sur deux
            parite = (parite + 1) % 2
            if i <= 8 and j <= 8 then
                if parite == 0 then
                    love.graphics.setColor(0.6, 0.6, 0.6, 1.0)
                else
                    love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
                end
                love.graphics.rectangle('fill', i*SCALE_FACTOR, j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
                love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
            end

            meeple = self.matrix[i][j]
            -- self.matrix[i][j]:draw()
            love.graphics.print(meeple.emoji, (meeple.i + 0.125) * SCALE_FACTOR, (meeple.j + 0.125) * SCALE_FACTOR, 0, 2, 2)

        end
    end
    love.graphics.line(SCALE_FACTOR*9, SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9)
    love.graphics.line(SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9, SCALE_FACTOR*9)

    -- on surligne de jaune la case actuellement sélectionnée par la souris ?
    if mouse_i >= 1 and mouse_i <= 8 and mouse_j >= 1 and mouse_j <= 8 then
        love.graphics.setColor(1, 1, 0.0, 0.5)
        love.graphics.rectangle('fill', mouse_i*SCALE_FACTOR, mouse_j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    end

    -- on surligne de vert la pièce actuellement sélectionnée à la souris ?
    if piece_selectionnee ~= nil then
        local p_i = piece_selectionnee.i
        local p_j = piece_selectionnee.j
        love.graphics.setColor(0, 1, 0.0, 0.5)
        love.graphics.rectangle('fill', p_i*SCALE_FACTOR, p_j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
    end

    -- maintenant, si la pièce sélectionnée est surlignée en vert, pour chaque case sur laquelle elle peut aller, on la surligne en bleu clair
    if piece_selectionnee ~= nil then
        for i = 1,8 do
            for j = 1,8 do
                if piece_selectionnee:mouvement_legal(i, j, plateau.matrix[i][j], plateau) then
                    love.graphics.setColor(0, 0, 1, 0.5)
                    love.graphics.rectangle('fill', i*SCALE_FACTOR, j*SCALE_FACTOR, SCALE_FACTOR, SCALE_FACTOR)
                    love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                end
            end
        end
    end
end
Plateau = Class{}

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
    self.matrix[2][1] = Cavalier(1, 2, false)
    self.matrix[3][1] = Fou(1, 3, false)
    self.matrix[4][1] = Reine(1, 4, false)
    self.matrix[5][1] = Roi(1, 5, false)
    self.matrix[6][1] = Fou(1, 6, false)
    self.matrix[7][1] = Cavalier(1, 7, false)
    self.matrix[8][1] = Tour(1, 8, false)

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

function Plateau:draw()
    for i = 1,8 do
        for j = 1,8 do
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, (i+1)*SCALE_FACTOR, j*SCALE_FACTOR)
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, i*SCALE_FACTOR, (j+1)*SCALE_FACTOR)
            -- TODO: dessiner des lignes sur les cases noires

            meeple = self.matrix[i][j]
            -- self.matrix[i][j]:draw()
            love.graphics.print(meeple.emoji, meeple.i * SCALE_FACTOR, meeple.j * SCALE_FACTOR, 0, 2, 2)

        end
    end
    love.graphics.line(SCALE_FACTOR*9, SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9)
    love.graphics.line(SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9, SCALE_FACTOR*9)
end
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
end

function Plateau:draw()
    for i = 1,8 do
        for j = 1,8 do
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, (i+1)*SCALE_FACTOR, j*SCALE_FACTOR)
            love.graphics.line(i*SCALE_FACTOR, j*SCALE_FACTOR, i*SCALE_FACTOR, (j+1)*SCALE_FACTOR)
            -- TODO: dessiner des lignes sur les cases noires

            meeple = self.matrix[i][j]
            -- self.matrix[i][j]:draw()
            love.graphics.print(meeple.emoji, meeple.i * SCALE_FACTOR, meeple.j * SCALE_FACTOR, 0, SCALE_FACTOR, SCALE_FACTOR)

        end
    end
    love.graphics.line(SCALE_FACTOR*9, SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9)
    love.graphics.line(SCALE_FACTOR, SCALE_FACTOR*9, SCALE_FACTOR*9, SCALE_FACTOR*9)
end
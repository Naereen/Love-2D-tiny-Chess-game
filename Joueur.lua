Joueur = Class{}

function Joueur:init(est_blanc)
    self.est_blanc = est_blanc
    if est_blanc then
        self.X = VIRTUAL_WIDTH / 2
        self.Y = 0
    else
        self.X = VIRTUAL_WIDTH / 2
        self.Y = VIRTUAL_HEIGHT - 20
    end

    -- nombre de pièces adverses déjà mangées
    self.score = 0
end

function Joueur:draw()
    if self.est_blanc then
        love.graphics.printf("Blanc : " .. tostring(self.score) .. "pièces mangées", self.X, self.Y, 25, 'center')
    else
        love.graphics.printf(" Noir : " .. tostring(self.score) .. "pièces mangées", self.X, self.Y, 25, 'center')
    end
end
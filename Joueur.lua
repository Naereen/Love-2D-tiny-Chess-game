Joueur = Class{}

function Joueur:init(est_blanc)
    self.est_blanc = est_blanc
    if est_blanc then
        self.X = 250
        self.Y = VIRTUAL_HEIGHT - 80
    else
        self.X = 250
        self.Y = 20
    end

    -- nombre de pièces adverses déjà mangées
    self.score = 0
end

function Joueur:draw()
    if self.est_blanc then
        love.graphics.printf("Blanc : " .. tostring(self.score) .. " pièces mangées", self.X, self.Y, 750, 'left')
    else
        love.graphics.printf(" Noir : " .. tostring(self.score) .. " pièces mangées", self.X, self.Y, 750, 'left')
    end
end
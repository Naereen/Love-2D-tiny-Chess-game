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

-- marque un score
function Joueur:marque_un_point()
    self.score = self.score + 1
end

-- affiche le score du joueur, en haut pour le joueur noir et en bas pour le joueur blanc
function Joueur:draw()
    if self.est_blanc then
        love.graphics.printf("Blanc : " .. tostring(self.score) .. " pièces ♟ mangées ", self.X, self.Y, 750, 'left')
    else
        love.graphics.printf(" Noir : " .. tostring(self.score) .. " pièces ♙ mangées", self.X, self.Y, 750, 'left')
    end
end
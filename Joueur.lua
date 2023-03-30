Joueur = Class{}

function Joueur:init(est_blanc)
    self.est_blanc = est_blanc
    if est_blanc then
        self.X = 225
        self.Y = VIRTUAL_HEIGHT - 50
    else
        self.X = 225
        self.Y = 10
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
    local joueur_est_actif = ""
    if joueur_actif == self then
        joueur_est_actif = "* "
    end
    if self.est_blanc then
        love.graphics.printf(joueur_est_actif .. "Joueur blanc : " .. tostring(self.score) .. " pièces ♟ mangées ", self.X, self.Y, 750, 'left')
    else
        love.graphics.printf(joueur_est_actif .. " Joueur noir : " .. tostring(self.score) .. " pièces ♙ mangées", self.X, self.Y, 750, 'left')
    end
end

function Joueur:message_a_gagne()
    if self.est_blanc then
        love.graphics.printf("Joueur blanc a gagné avec un score de " .. tostring(self.score) .. " pièces ♙ mangées", self.X, self.Y, 750, 'left')
        print("Joueur blanc a gagné avec un score de " .. tostring(self.score) .. " pièces ♙ mangées")
    else
        love.graphics.printf("Joueur noir a gagné avec un score de " .. tostring(self.score) .. " pièces ♙ mangées", self.X, self.Y, 750, 'left')
        print("Joueur noir a gagné avec un score de " .. tostring(self.score) .. " pièces ♙ mangées")
    end
end
Vide = Class{__includes = Meeple}

function Vide:init(i, j)
    self.i = i
    self.j = j
    self.emoji = ' '
    self.est_vide = true
    self.est_blanc = nil
end

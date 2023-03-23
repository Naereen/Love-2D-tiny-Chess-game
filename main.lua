-- Love2DChess : a tiny Chess program
-- Author: Lilian Besson
-- License: MIT License

-- push is a library that will allow us to draw our game at a virtual resolution, instead of however large our window is; used to provide a more retro aesthetic
-- https://github.com/Ulydev/push
push = require 'push'


-- the "Class" library we're using will allow us to represent anything in our game as code, rather than keeping track of many disparate variables and methods
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'class'

require 'Piece'
require 'Vide'
require 'Pion'
require 'Tour'
require 'Fou'
require 'Cavalier'
require 'Roi'
require 'Reine'
require 'Plateau'            -- TODO:

require 'Joueur'             -- TODO:

-- require 'APIStockFishChess'  -- TODO:

-- size of our actual window
WINDOW_WIDTH = 720
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 1000
VIRTUAL_HEIGHT = 1000

-- pour dessiner les Pieces
SCALE_FACTOR = 100

-- pour savoir où est la souris actuellement
mouse_i = 1
mouse_j = 1

-- quelle pièce est sélectionnée
piece_selectionnee = nil

-- Load stuff at the beginning of the game
function love.load()
    plateau = Plateau()
    joueur_blanc = Joueur(true)
    joueur_noir  = Joueur(false)
    -- TODO: remplacer le joueur noir par un bridge API à APIStockFishChess

    -- joueur actif, commence par le blanc puis alternera blanc > noir > blanc > noir etc.
    joueur_actif = joueur_blanc

    -- set the title of our application window
    love.window.setTitle('Love 2D Chess - par Lilian Besson')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- initialize a text font with UTF8 emojis
    tinyFont = love.graphics.newFont("FreeSerif.ttf", 20)
    scoreFont = love.graphics.newFont("FreeSerif.ttf", 40)
    love.graphics.setFont(scoreFont)

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
        canvas = false
    })
end

-- React to key pressed?
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- Update the state of the game, every frame
function love.update(delta_time)
    -- plateau:update(delta_time)
    if love.mouse.isDown(1) then
        piece_selectionnee = plateau.matrix[mouse_i][mouse_j]
        if piece_selectionnee.est_vide then
            piece_selectionnee = nil
        end
        -- DONE colorier en vert clair cette case de départ de déplacement
    elseif love.mouse.isDown(2) then
        -- un clic droit sur une pièce d'arrivée fait le mouvement
        local piece_arrivee = plateau.matrix[mouse_i][mouse_j]
        local i, j = piece_selectionnee.i, piece_selectionnee.j
        local new_i, new_j = piece_arrivee.i, piece_arrivee.j
        if piece_selectionnee:mouvement_legal(new_i, new_j, piece_arrivee, plateau) then
            Plateau:deplace(i, j, new_i, new_j)
        end
    end
end

-- Draw the frame
function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:start()

    love.graphics.clear(40/255, 40/255, 40/255, 255/255)

    -- dessiner le plateau
    plateau:draw()

    -- afficher le score des deux joueurs
    joueur_blanc:draw()
    joueur_noir:draw()

    -- display FPS for debugging; simply comment out to remove
    displayFPS()

    -- end our drawing to push
    push:finish()
end

function love.mousemoved(x, y, dx, dy, istouch)
    -- étape 1 : calculer coordonnées (i,j) de la case du plateau
    -- TODO: ne pas utiliser 72 comme hard constant, mais un truc malin ?
    mouse_i = math.floor(x / 72)
    mouse_j = math.floor(y / 72)
    -- étape 2 : colorier cette case, à faire dans plateau:draw()
    -- étape 3 : machine à état, autoriser le déplacement potentiel de la pièce sélectionnée
end

-- Renders the current FPS.
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(tinyFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 10, 10)
    -- love.graphics.print('FPS: ' .. love.timer.getFPS() .. ' mouse_i = ' .. mouse_i .. ' mouse_j = ' .. mouse_j, 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(scoreFont)
end

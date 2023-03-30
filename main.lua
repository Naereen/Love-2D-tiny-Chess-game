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
require 'Plateau'

require 'Joueur'

require 'sunfish'  -- TODO:
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

-- est-ce que le jeu est fini ?
jeu_fini = false

-- Load stuff at the beginning of the game
function love.load()

    -- set the title of our application window
    love.window.setTitle('Love 2D Chess - par Lilian Besson')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- Le plateau, joueurs blanc et noir
    plateau = Plateau()
    joueur_blanc = Joueur(true)
    joueur_noir  = Joueur(false)
    -- TODO: remplacer le joueur noir par un bridge API à APIStockFishChess

    -- on initialise une PositionSunfish
    -- TODO: mettre ça de façon cachée dans Plateau ?
    position_sunfish = PositionSunfish.new(initial_sunfish, 0, {true, true}, {true, true}, 0, 0)
    printboard_sunfish(position_sunfish.board)

    -- Documentation :
    -- appliquer un mouvement à ce plateau ce fait avec
    -- position_sunfish = position_sunfish:move(move_sunfish)
    -- il faut ensuite afficher le plateau avec
    -- printboard(position_sunfish:rotate().board)

    -- joueur actif, commence par le blanc puis alternera blanc > noir > blanc > noir etc.
    joueur_actif = joueur_blanc

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
    if key == 's' or key == 'h' then
        -- fire up the engine to look for a move for the current player!
        if joueur_actif == joueur_blanc then
            position_sunfish = position_sunfish:rotate()
        end
        local move_sunfish, score_sunfish = search_sunfish(position_sunfish)
        if move_sunfish ~= nil then
            -- print("move, score = ", move_sunfish, score_sunfish) -- DEBUG
            print("My move = ", render_sunfish(119-move_sunfish[1]) .. render_sunfish(119-move_sunfish[2]))
            -- TODO: print this move to the screen game, not just the console
        end
        if joueur_actif == joueur_blanc then
            position_sunfish = position_sunfish:rotate()
        end
    end
end

-- Update the state of the game, every frame
function love.update(delta_time)
    -- si le jeu est fini, on ne fait plus d'interaction
    if jeu_fini then return end

    if love.mouse.isDown(1) then
        piece_selectionnee = plateau.matrix[mouse_i][mouse_j]
        if piece_selectionnee.est_vide then
            piece_selectionnee = nil
        end
        -- DONE colorier en vert clair cette case de départ de déplacement
    elseif love.mouse.isDown(2) then
        if piece_selectionnee == nil then
            return
        end
        -- un clic droit sur une pièce d'arrivée fait le mouvement
        local piece_arrivee = plateau.matrix[mouse_i][mouse_j]
        local i, j = piece_selectionnee.i, piece_selectionnee.j
        local new_i, new_j = piece_arrivee.i, piece_arrivee.j
        if piece_selectionnee:mouvement_legal(new_i, new_j, piece_arrivee, plateau) then
            Plateau:deplace(i, j, new_i, new_j)
            -- TODO: aussi faire ce déplacement sur position_sunfish
            local lettres = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'}
            local crdn = string.format("%s%d%s%d", lettres[i], 9-j, lettres[new_i], 9-new_j)
            -- print("crdn = ", crdn)  -- FIXME: remove this DEBUG line
            local move = {parse_sunfish(crdn:sub(1,2)), parse_sunfish(crdn:sub(3,4))}
            -- print("move[1] =", move[1])  -- FIXME: remove this DEBUG line
            -- print("move[2] =", move[2])  -- FIXME: remove this DEBUG line
            position_sunfish = position_sunfish:move(move)
            printboard_sunfish(position_sunfish.board)
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

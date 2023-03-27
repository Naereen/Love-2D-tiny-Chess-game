build_lovezip:
	zip -r Love2DChess.zip ./*.lua ./*.ttf *./README ./LICENSE
	mv Love2DChess.zip Love2DChess.love

build_lovejs:
	# npx love.js [options] <input> <output>
	npx love.js --compatibility --title "Love2D chess by Lilian Besson" --memory 17798533 ./Love2DChess.love www/

test_lovejs:
	firefox http://localhost:8910/ &
	cd www/ && python3 -m http.server 8910

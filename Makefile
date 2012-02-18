build:
	npm install
	coffee --bare -o ./ -c ./src/app.coffee
	mkdir ./models
	coffee -o ./models -c ./src/models/*.coffee
	mkdir ./routes
	coffee -o ./routes -c ./src/routes/*.coffee
	mkdir ./public
	mkdir ./public/javascripts
	coffee -o ./public/javascripts -c ./src/public/coffeescripts/*.coffee
	cp -R ./src/public/stylesheets ./public/stylesheets
	cp -R ./src/public/images ./public/images
	cp -R ./src/views ./views

install:
	sudo apt-get install mongodb
	make build

test:
	echo "Not Implemented Yet"

clean:
	rm -rf ./models
	rm -rf ./routes
	rm -rf ./views
	rm -rf ./public
	rm ./app.js
	rm -rf ./node_modules

rebuild:
	make clean
	make build

run:
	make rebuild
	sudo node ./bin/app.js

.PHONY: build install test clean rebuild run

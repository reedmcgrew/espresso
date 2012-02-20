#COMPILATION
compile-models:
	mkdir ./models
	coffee -o ./models -c ./src/models/*.coffee

compile-routes:
	mkdir ./routes
	coffee -o ./routes -c ./src/routes/*.coffee

compile-static-files:
	mkdir ./public
	mkdir ./public/javascripts
	coffee -o ./public/javascripts -c ./src/public/coffeescripts/*.coffee
	cp -R ./src/public/stylesheets ./public/stylesheets
	cp -R ./src/public/images ./public/images
	
compile-views:
	cp -R ./src/views ./views

compile-server:
	coffee --bare -o ./ -c ./src/*.coffee
	
compile:
	make compile-models
	make compile-routes
	make compile-static-files
	make compile-views
	make compile-server

#ADMINISTRATIVE
build:
	make compile

test:
	make build
	nodeunit models/test*

retest:
	make rebuild
	nodeunit models/test*

clean:
	rm -rf ./models
	rm -rf ./routes
	rm -rf ./views
	rm -rf ./public
	rm ./*.js

rebuild:
	make clean
	make build

install:
	npm install
	make build

uninstall:
	rm -rf ./node_modules
	make clean

run:
	make rebuild
	sudo node ./bin/app.js

#DATABASE MIGRATIONS
up:
	mysql -u root < ./src/migrations/up.sql

down:
	mysql -u root < ./src/migrations/down.sql

re-up:
	make down
	make up


.PHONY: db-up db-down compile-models compile-routes compile-static-files compile-views compile-server compile build test retest clean rebuild install uninstall run

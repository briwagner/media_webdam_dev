vendor:
	composer install

test-unit: vendor
	./vendor/bin/phpunit

test-browser: vendor
	php ./core/scripts/run-tests.sh --types "Simpletest" --module 'media_webdam'

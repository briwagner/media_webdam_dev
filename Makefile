
vendor:
	composer install

test-unit: vendor
	./vendor/bin/phpunit


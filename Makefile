SHELL=/bin/bash
ESCAPED_PWD := $(shell echo ${PWD} | sed 's/\//\\\//g')

vendor:
	composer install

test-unit: vendor
	./vendor/bin/phpunit

test-browser: vendor
	php ./core/scripts/run-tests.sh --types "Simpletest" --module 'media_webdam'

test-coverage-html:
	./vendor/bin/phpunit --coverage-html=coverage
	@echo "Open ./coverage/index.html in a browser for code coverage details"

report-coverage:
	./vendor/bin/phpunit --coverage-clover coverage.xml
	./vendor/bin/coveralls
	rm coveralls_upload.json coverage.xml

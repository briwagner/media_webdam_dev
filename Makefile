SHELL=/bin/bash

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

travis-install-site:
	./vendor/bin/drush si --yes --db-url=mysql://root:@127.0.0.1:3306/drupal_travis_db --site-name="media_webdam"
	./vendor/bin/drush en --yes media media_webdam simpletest



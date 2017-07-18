SHELL=/bin/bash

vendor:
	composer install

libraries:
	mkdir -p libraries
	@echo "Downloading Dropzone JS"
	wget https://github.com/enyo/dropzone/archive/v4.3.0.tar.gz
	tar xzf v4.3.0.tar.gz
	rm v4.3.0.tar.gz
	mv dropzone-4.3.0 libraries/dropzone

dependencies: vendor libraries

test-unit: dependencies
	./vendor/bin/phpunit

test-browser: dependencies
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

travis-test-browser:
	php ./core/scripts/run-tests.sh --types "Simpletest" --module 'media_webdam' --dburl "mysql://root:@localhost:3306/drupal_travis_db#simpletest" --php `which php`



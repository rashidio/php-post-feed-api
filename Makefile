up:
	docker-compose up -d --build

down:
	docker-compose down

logs:
	@if [ "$$CI" = "true" ]; then \
		docker-compose logs; \
	else \
		docker-compose logs -f; \
	fi

seed:
	docker-compose exec -T app php seed.php

build-wrk:
	docker-compose build wrk

perf-feed:
	docker-compose run --rm wrk -t4 -c500 -d10s -s /wrk/scripts/feed.lua http://app:8000

perf-view:
	docker-compose run --rm wrk -t4 -c500 -d10s -s /wrk/scripts/view.lua http://app:8000

perf-all:
	$(MAKE) perf-feed
	$(MAKE) perf-view

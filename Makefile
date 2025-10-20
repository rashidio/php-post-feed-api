up:
	docker-compose up -d --build > /dev/null 2>&1
	@echo "✅ Services started successfully"

down:
	docker-compose down

logs:
	@if [ "$$CI" = "true" ]; then \
		docker-compose logs; \
	else \
		docker-compose logs -f; \
	fi

app:
	docker-compose exec php sh

seed:
	docker-compose exec -T php php scripts/seed.php

perf-feed:
	docker-compose exec wrk wrk -t4 -c50 -d30s -s /wrk/scripts/feed.lua http://nginx:8000

perf-view:
	docker-compose exec wrk wrk -t4 -c50 -d30s -s /wrk/scripts/view.lua http://nginx:8000

perf-feed-heavy:
	docker-compose exec wrk wrk -t8 -c200 -d60s -s /wrk/scripts/feed.lua http://nginx:8000

perf-view-heavy:
	docker-compose exec wrk wrk -t8 -c200 -d60s -s /wrk/scripts/view.lua http://nginx:8000

perf-all:
	$(MAKE) perf-view
	$(MAKE) perf-feed

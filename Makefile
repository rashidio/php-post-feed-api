up:
	docker-compose up -d --build

down:
	docker-compose down

logs:
	docker-compose logs -f

seed:
	docker-compose exec -T app php seed.php

# Perf test feed API with Lua
perf-feed:
	docker-compose run --rm wrk -t4 -c500 -d10s -s /wrk/scripts/feed.lua http://app:8000

# Perf test view API with Lua
perf-view:
	docker-compose run --rm wrk -t4 -c500 -d10s -s /wrk/scripts/view.lua http://app:8000

# Run both sequentially
perf-all:
	$(MAKE) perf-feed
	$(MAKE) perf-view

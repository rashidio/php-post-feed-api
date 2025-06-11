up:
	docker-compose up -d --build

down:
	docker-compose down

logs:
	docker-compose logs -f

seed:
	docker-compose exec app php seed.php

# Perf test feed API
perf-feed:
	docker-compose run --rm wrk -t4 -c500 -d10s http://app:8000/api/feed.php?user_id=1\&last_hotness=1452\&last_id=4699

# Perf test view API
perf-view:
	docker-compose run --rm wrk -t4 -c500 -d10s http://app:8000/api/view.php?user_id=1\&post_id=1452

# Run both sequentially
perf-all:
	$(MAKE) perf-feed
	$(MAKE) perf-view

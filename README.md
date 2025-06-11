# PHP Post feed API

Proof of concept API for a post feed system with MySQL backend. Features include:

* Keyset pagination for efficient large dataset handling
* Batch seeding of 50k posts with random data
* Feed endpoint with smart filtering (excludes seen posts & over-exposed content - 1000 views)
* View tracking endpoint with atomic operations

## Endpoints

**Feed API - GET /api/feed.php**

- Parameters: user_id, last_hotness, last_id (for pagination when last_hotness is identical)
- Returns: 50 posts sorted by hotness (desc) excluding:
- Posts user has seen
- Posts with >1000 views
- Keyset pagination: WHERE (hotness < ? OR (hotness = ? AND id < ?))

**View API - GET /api/view.php**

- Parameters: user_id, post_id
- Actions:
- Records view in user_views
- Atomically increments post's view count

## 🚀 Usage

```bash
make up       # Start containers (PHP app + MySQL)
make seed     # Seed 50k posts (batches of 1000)
```

## 📊 Performance Tests

Benchmark API endpoints with wrk and Lua scripts to randomize request query:

```bash
make perf-all   # Run both performance tests below sequentially

make perf-feed  # Test feed endpoint
make perf-view  # Test view endpoint
```

## 📦 Requirements

- Docker
- Docker Compose
- Make

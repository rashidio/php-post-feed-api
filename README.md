# PHP Post Feed API

Simple PHP API demonstrating keyset pagination for large datasets with MySQL backend.

## What It Does

- **Feed endpoint**: Returns posts sorted by hotness, excluding seen posts and over-exposed content
- **View endpoint**: Tracks user views and increments post view counts
- **Keyset pagination**: Efficient pagination using `(hotness < ? OR (hotness = ? AND id < ?))` for large datasets

## API Endpoints

### Feed API
```bash
GET /api/feed.php?user_id=1&last_hotness=99950&last_id=12345
```
Returns 50 posts sorted by hotness (desc), excluding:
- Posts user has already seen
- Posts with >1000 views

### View API
```bash
POST /api/view.php
Content-Type: application/x-www-form-urlencoded

user_id=1&post_id=12345
```
Records view and atomically increments post view count.

## Quick Start

```bash
make up       # Start containers
make seed     # Seed 50k posts
make perf-all # Run performance tests
```

## Performance Tests

```bash
make perf-view  # ~924 req/sec
make perf-feed  # ~682 req/sec
```

Expected performance with nginx + php-fpm setup.

## CI/CD

- **`ci.yml`**: Runs on every push/PR with health checks + performance tests
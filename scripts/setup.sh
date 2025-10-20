#!/bin/bash

echo "🚀 Setting up improved PHP Post Feed API for benchmarking..."

echo "📦 Rebuilding containers with new configuration..."
make down
make up

echo "⏳ Waiting for services to be ready..."
sleep 10

echo "🌱 Seeding database..."
make seed

echo "✅ Setup complete! You can now run benchmarks:"
echo ""
echo "For moderate load testing:"
echo "  make perf-view    # Test view endpoint"
echo "  make perf-feed    # Test feed endpoint"
echo "  make perf-all     # Test both endpoints"
echo ""
echo "For heavy load testing:"
echo "  make perf-view-heavy    # Heavy view endpoint test"
echo "  make perf-feed-heavy    # Heavy feed endpoint test"
echo ""
echo "Key improvements made:"
echo "  ✅ Switched from PHP dev server to nginx + php-fpm"
echo "  ✅ Reduced concurrent connections from 500 to 50 (moderate) / 200 (heavy)"
echo "  ✅ Increased threads from 1 to 4 (moderate) / 8 (heavy)"
echo "  ✅ Extended test duration from 10s to 30s (moderate) / 60s (heavy)"
echo "  ✅ Added database indexes for better query performance"
echo "  ✅ Optimized PHP-FPM configuration for concurrency"

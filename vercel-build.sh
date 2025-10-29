#!/usr/bin/env bash
set -euo pipefail

echo "=== Vercel Jekyll build script ==="
echo "Ruby version:"
ruby -v || true

# ensure gem and bundler are available
if ! command -v bundle >/dev/null 2>&1; then
  echo "Installing bundler..."
  gem install bundler --no-document
fi

echo "Running bundle install (may take a minute)..."
bundle config set --local deployment 'false' || true
bundle config set --local path 'vendor/bundle' || true
bundle install --jobs=4 --retry=3

echo "Building site with Jekyll..."
bundle exec jekyll build --trace

echo "Build finished. Output directory: _site"

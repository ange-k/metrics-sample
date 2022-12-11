#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# 毎回db初期化されている前提.(サンプルコード用)
rails db:setup
exec "$@"
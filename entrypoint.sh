#!/bin/bash
set -e

# 環境変数ファイルを読み込む
if [ -f setting.env ]; then
  export $(cat setting.env | grep -v '^#' | xargs)
fi

# データベースのセットアップとマイグレーション
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

# Railsサーバーを起動
exec "$@"


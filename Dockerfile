FROM ruby:3.0.5

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    default-mysql-client \
    nodejs \
    imagemagick \
    yarn

# 作業ディレクトリの設定
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile* ./

# Bundlerのインストールと実行
RUN gem install bundler:2.4.22
RUN bundle install

# アプリケーションのコピー
COPY . .

EXPOSE 3000

# エントリーポイントスクリプトの設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.1.3-bullseye AS build
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.26
RUN bundle install

FROM ruby:3.1.3-slim-bullseye AS base
# https://rubygems.org/gems/bundler/versions/1.17.2?locale=ja
RUN gem install bundler:2.3.26
WORKDIR /usr/src/app

FROM base AS deploy
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build Gemfile* ./
COPY . .
COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

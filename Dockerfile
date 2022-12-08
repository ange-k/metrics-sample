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
RUN apt update -qq && apt-get install -y lsb-release gnupg wget
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN apt update -qq && \
    apt-get install -y \
        postgresql-client
RUN bundle install
RUN \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
ENV RAILS_ENV development
ENV RAILS_LOG_TO_STDOUT true
CMD ["rails", "server", "-b", "0.0.0.0"]

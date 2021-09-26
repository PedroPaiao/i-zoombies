FROM ruby:3.0.1

RUN apt-get update -qq && apt-get install -y curl \
                                             build-essential \
                                             libssl-dev \
                                             libpq-dev

LABEL Name=izoombies Version=0.0.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

ENV app /app
RUN mkdir $app
WORKDIR $app
ADD . $app

RUN gem install bundler:2.2.22

COPY Gemfile Gemfile.lock ./
RUN bundle install

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
RUN bundle install

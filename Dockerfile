FROM ruby:3.0.1

RUN apt-get update -qq && apt-get install -y curl \
                                             build-essential \
                                             libssl-dev \
                                             libpq-dev

LABEL Name=izoombies Version=0.0.1
ENV BUNDLER_VERSION=2.2.22
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV app /app

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN mkdir $app
WORKDIR $app
ADD . $app

RUN gem install bundler -v 2.2.22

COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

COPY . ./
EXPOSE 3000


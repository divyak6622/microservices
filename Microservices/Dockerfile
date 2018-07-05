FROM ruby:2.4.1

RUN apt-get update && apt-get install -y build-essential nodejs

RUN mkdir -p /app/greetings
WORKDIR /app/greetings
USER root

COPY ./app/greetings/Gemfile ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY ./app/greetings ./

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

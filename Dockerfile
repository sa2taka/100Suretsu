FROM ruby

ADD . /app
WORKDIR /app
RUN bundle install

CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0"]

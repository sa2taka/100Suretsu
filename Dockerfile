FROM ruby

ADD . /app
WORKDIR /app
RUN bundle install

ENV APP_ENV production
EXPOSE 9292
CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0"]

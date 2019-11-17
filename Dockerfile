FROM ruby

ADD . /app
WORKDIR /app
RUN bundle install

ENV APP_ENV production
ENV flag FLAG{|uca@s_cann0t_sh0t_st@rst0rm}
EXPOSE 9292
CMD ["bundle", "exec", "rackup", "config.ru", "-o", "0.0.0.0"]

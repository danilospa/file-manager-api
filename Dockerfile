FROM ruby:2.5.1

COPY . /app
WORKDIR /app

RUN bundle -j4 --without development test

expose 3000
CMD ["bundle", "exec", "puma"]

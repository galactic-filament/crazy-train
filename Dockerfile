FROM ruby:2.7-alpine

# alpine deps install
RUN apk add --virtual native-deps \
  build-base postgresql-dev sqlite-dev tzdata

ENV RAILS_ENV production

# add app dir
ENV APP_DIR /srv/app
COPY ./app/crazy_train $APP_DIR
WORKDIR $APP_DIR

# bundle deps
RUN bundle install

# alpine deps cleanup
#RUN apk del native-deps

EXPOSE 80
ENV APP_PORT 80

CMD ["./bin/run-app.sh"]

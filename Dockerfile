FROM ruby:3.1-alpine as build-env

# alpine deps install
RUN apk add --virtual native-deps \
  build-base postgresql-dev sqlite-dev tzdata

# misc
ENV RAILS_ENV production

# add app dir
ENV APP_DIR /srv/app
COPY ./app/crazy_train $APP_DIR
WORKDIR $APP_DIR

# bundle deps
RUN bundle install --jobs=8 --retry=3

# alpine deps cleanup
RUN apk del native-deps


FROM ruby:3.1-alpine as runtime-env

# alpine deps install
RUN apk add --virtual native-deps \
  postgresql-dev tzdata

# misc
ENV RAILS_ENV production

# app port
EXPOSE 80
ENV APP_PORT 80

# importing from build-env
COPY --from=build-env /srv/app /srv/app
WORKDIR /srv/app

COPY --from=build-env /usr/local/bundle /usr/local/bundle

CMD ["./bin/run-app.sh"]

FROM ruby:2.7

# alpine deps install

# add app dir
ENV APP_DIR /srv/app
COPY ./app $APP_DIR
WORKDIR $APP_DIR

# bundle deps
RUN bundle install

# alpine deps cleanup

EXPOSE 80
ENV APP_PORT 80

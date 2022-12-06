FROM ruby:3.2-rc

#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
#RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
#RUN apt-get update -qq && apt-get install -y build-essential nodejs yarn git
RUN gem install solargraph

WORKDIR /code

COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock

RUN bundle install

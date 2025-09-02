FROM ruby:3.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler 
RUN bundle install --jobs 4 --retry 3 

RUN gem install rerun

COPY . .

EXPOSE 3000

CMD ["rerun", "--", "rackup", "-o", "0.0.0.0", "-p", "3000"]


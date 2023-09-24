FROM jekyll/jekyll:pages

# https://stackoverflow.com/questions/65989040/bundle-exec-jekyll-serve-cannot-load-such-file
RUN gem install webrick
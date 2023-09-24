# FROM jekyll/jekyll:4.3
# FROM ubuntu:23.04
FROM ruby:3.0

RUN apt-get update && apt-get install -y build-essential zlib1g-dev


# RUN gem install jekyll bundler



# ENV GEM_HOME="$HOME/gems"
# ENV PATH="$HOME/gems/bin:$PATH"


# ENV BUNDLE_HOME=/usr/local/bundle
# ENV BUNDLE_APP_CONFIG=/usr/local/bundle
# ENV BUNDLE_DISABLE_PLATFORM_WARNINGS=true
# ENV BUNDLE_BIN=/usr/local/bundle/bin
# ENV GEM_BIN=/usr/gem/bin
# ENV GEM_HOME=/usr/gem
# ENV JEKYLL_DATA_DIR=/srv/jekyll
# ENV JEKYLL_BIN=/usr/jekyll/bin
# ENV JEKYLL_VAR_DIR=/var/jekyll
# ENV PATH="$JEKYLL_BIN:$PATH"
ENV JEKYLL_ENV=development

RUN gem update --system

RUN gem install --force bundler
RUN gem install jekyll -v4.3 -- --use-system-libraries


# https://stackoverflow.com/questions/65989040/bundle-exec-jekyll-serve-cannot-load-such-file
RUN gem install webrick -- --use-system-libraries
#--use-system-libraries
# RUN gem install bundler -- --use-system-libraries
#--use-system-libraries

# RUN gem install html-proofer -- \
    # --use-system-libraries

RUN gem install jekyll-watch -- --use-system-libraries
#-- --use-system-libraries
# RUN gem install jekyll-assets
# RUN gem install jekyll-reload -- \
    # --use-system-libraries
#jekyll-mentions jekyll-coffeescript jekyll-sass-converter jekyll-commonmark jekyll-paginate jekyll-compose jekyll-assets RedCloth kramdown jemoji --
    #--use-system-libraries


# RUN adduser --help
# RUN addgroup --system --gid 1000 jekyll
# RUN adduser --system -gid 1000 -uid 1000 jekyll
# RUN adduser --system --group -gid 1000 jekyll
# RUN adduser -G jekyll jekyll

# RUN mkdir -p $JEKYLL_VAR_DIR
# RUN mkdir -p $JEKYLL_DATA_DIR
# RUN chown -R jekyll:jekyll $JEKYLL_DATA_DIR
# RUN chown -R jekyll:jekyll $JEKYLL_VAR_DIR
# RUN chown -R jekyll:jekyll $BUNDLE_HOME

# RUN chown -R jekyll:jekyll /usr/gem/cache/bundle

# ENV JEKYLL_UID=1000
# ENV JEKYLL_GID=1000

CMD ["jekyll", "--help"]
#ENTRYPOINT ["jekyll"]
# ENTRYPOINT ["/usr/jekyll/bin/entrypoint"]
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000
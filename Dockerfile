FROM mhart/alpine-node

MAINTAINER Zeng Shu <ist@insilicotech.co.jp>

# If you have native dependencies, you'll need extra tools
# RUN apk add --no-cache make gcc g++ python

# Environment configuration
# ENV GITBOOK_VERSION=3.2.2
# Replace hard coding by following command:
#   gitbook ls-remote | grep latest|cut -d':' -f2| sed 's/ //g'
ENV BOOKDIR /gitbook

# If you need npm, don't use a base tag
RUN apk update \
    && apk add --no-cache grep sed \
    && npm install gitbook-cli -g \
    && gitbook fetch $(gitbook ls-remote | grep latest|cut -d':' -f2| sed 's/ //g') \
    && npm cache clear \
    && apk del grep sed \
    && rm -rf /tmp/*

VOLUME $BOOKDIR
WORKDIR $BOOKDIR
EXPOSE 4000 35729

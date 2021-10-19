FROM ubuntu:20.04
FROM node:7
ENV NODE_ENV=production
WORKDIR /usr/src/app
ENV TERM="xterm" LANG="C.UTF-8" LC_ALL="C.UTF-8"


# Had to add this so that I don't go crazy
STOPSIGNAL SIGKILL


# Init Production
RUN npm install --production --silent && mv node_modules ../

# This seems to help
RUN npm install

# Funky workaround for Gulp not always showing on runtime
RUN npm install --global gulp

# This line alone equally causes and fixes issues
RUN npm install gulp && npm install gulp-cli

# Get the rest of our NPM packages because we kinda need them
RUN curl https://raw.githubusercontent.com/samuelmiller36/gm_gulper_compost/main/init.sh | bash
COPY . .

# This fork just allows for dynamic cloud storage and plus git capabilities
RUN git clone https://github.com/samuelmiller36/load-seed

# This still doesn't work but I'm still thinking about it
#RUN curl https://raw.githubusercontent.com/samuelmiller36/gm_gulper_compost/main/Force_Change_Directory.sh | bash
WORKDIR /usr/src/app/load-seed
EXPOSE 9000
RUN chown -R node /usr/src/app
USER node

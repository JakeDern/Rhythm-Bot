FROM docker.io/library/node:12

# RUN apt-get update && apt-get install curl -y --no-install-recommends
# RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
# RUN source ~/.profile && nvm install node v12
RUN apt-get update && apt-get install sqlite3 -y --no-install-recommends

RUN useradd --create-home rhythmbot
USER rhythmbot
WORKDIR /home/rhythmbot

COPY package.json/ ./
COPY package-lock.json/ ./
COPY tsconfig.mikro-orm.json ./
RUN npm install

COPY tsconfig.json/ ./
COPY src/ ./src
RUN npm run build

COPY helptext.txt ./

COPY LICENSE ./
COPY README.md ./

RUN mkdir -p data
RUN sqlite3 data/rhythm.db

CMD npm run start:prod

# HEALTHCHECK CMD

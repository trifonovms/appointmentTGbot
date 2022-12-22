FROM node:14-alpine
RUN mkdir -p /usr/src/app
COPY ./src/* /usr/src/app/
WORKDIR /usr/src/app
RUN npm install
RUN npm i typescript --save-dev
RUN npm i --save-dev @types/debug
RUN npx tsc
ENV NODE_ENV=production
RUN apt-get install libcap2-bin 
RUN setcap cap_net_bind_service=+ep `readlink -f \`which node\`` 
EXPOSE 80
USER node
CMD node /usr/src/app/dist/index.js
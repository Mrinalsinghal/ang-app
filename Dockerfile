# # base image
# FROM node:12.2.0

# # set working directory
# WORKDIR /app

# # add `/app/node_modules/.bin` to $PATH
# ENV PATH /app/node_modules/.bin:$PATH

# # install and cache app dependencies
# COPY package.json /app/package.json
# RUN npm install
# RUN npm install -g @angular/cli@7.3.9

# # add app
# COPY . /app

# # start app
# CMD ng serve --host 0.0.0.0

FROM node:11.6.0-alpine AS builder
COPY . ./ang-app
WORKDIR /ang-app
RUN npm i
RUN npm run build --prod

# $(npm bin)/

FROM nginx:1.15.8-alpine
COPY --from=builder /ang-app/dist/ang-app/ /usr/share/nginx/html
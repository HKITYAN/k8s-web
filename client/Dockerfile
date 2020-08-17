#Build Phase
FROM node:alpine as builder
WORKDIR '/client'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# this is only for elastic beanstalk to consume. It has no use in normal docker build
EXPOSE 3000

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# --from=builder reference from builder context
COPY --from=builder /client/build /usr/share/nginx/html
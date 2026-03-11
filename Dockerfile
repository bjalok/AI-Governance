# Stage 1: Build the React app
FROM node:20 AS build

WORKDIR /app

# copy package files
COPY package*.json ./

# install dependencies
RUN npm install

# copy source code
COPY . .

# build the app
RUN npm run build


# Stage 2: Serve with Nginx
FROM nginx:alpine

# copy build files
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


# Use an official Node runtime as a parent image
FROM node:latest

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY ./src /app/src
COPY ./public /app/public

COPY package*.json /app/

# Create the npm cache directory and change ownership
RUN mkdir -p /home/node/.npm && \
    chown -R node:node /home/node/.npm

# Change the ownership of the working directory
RUN chown -R node:node /app

USER node

# Set npm cache directory
ENV NPM_CONFIG_CACHE=/home/node/.npm

# Install app dependencies
RUN npm install --loglevel=verbose

RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run your app
CMD ["npm", "start"]

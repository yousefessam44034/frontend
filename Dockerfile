FROM node:latest

WORKDIR /app

# Copy package files
COPY package*.json ./

# Set permissions for the project directory
RUN chown -R node:node /app

USER node

# Install dependencies
RUN npm install

# Change ownership of the .npm directory
USER root
RUN chown -R 1002120000:0 /app/.npm

USER node

# Copy the rest of the application files
COPY --chown=node:node . .

EXPOSE 3000

CMD ["npm", "start"]

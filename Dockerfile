FROM node:latest

WORKDIR /app

# Copy package files and set permissions
COPY package*.json ./
RUN chown -R node:node /app

USER node

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY --chown=node:node . .

EXPOSE 3000

CMD ["npm", "start"]

# Stage 1: Build the application
FROM node:latest AS builder

WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .

# Build the application
RUN npm run build

# Stage 2: Create a smaller image for running the application
FROM node:alpine

WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app/build ./build
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

# Expose the port on which the app will run
EXPOSE 3000

# Set the command to run your application
CMD ["npm", "start"]

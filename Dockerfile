# ---- Base Stage ----
# Use an official Node.js runtime as a parent image.
# Using a specific version is better for reproducibility.
FROM node:18-alpine AS base

# Set the working directory in the container.
WORKDIR /usr/src/app

# ---- Dependencies Stage ----
# This stage is only for installing dependencies.
FROM base AS dependencies
# Copy package.json and package-lock.json.
COPY package*.json ./
# Install app dependencies.
RUN npm ci --only=production

# ---- Build Stage ----
# This stage copies the source code.
FROM base AS build
# Copy the installed dependencies from the 'dependencies' stage.
COPY --from=dependencies /usr/src/app/node_modules ./node_modules
# Copy the application source code.
COPY . .

# ---- Final Stage ----
# This is the final, small, and secure image that will be deployed.
FROM base
# Copy the built application from the 'build' stage.
COPY --from=build /usr/src/app /usr/src/app

# The service will bind to this port. Google Cloud Run provides the PORT env var.
# We default to 8080 if it's not set.
ENV PORT 8080

# Expose the port.
EXPOSE 8080

# Define the command to run your app.
CMD [ "node", "index.js" ]
FROM node:25.4-alpine

WORKDIR /app

# 1. On installe les dépendances
COPY package.json yarn.lock ./
RUN --mount=type=cache,target=/root/.cache/yarn \
    yarn install

# 2. IMPORTANT : On copie tout le code du site dans l'image
COPY . .

# 3. Configuration pour Render (Force le port et l'accès public)
ENV HOST=0.0.0.0
ENV PORT=10000
ENV NUXT_PUBLIC_API_BASE=https://ats-1-ssno.onrender.com

# 4. On expose le port
EXPOSE 10000

# 5. Démarrage simple (sans attendre de base de données)
CMD ["yarn", "dev"]

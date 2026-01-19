FROM node:24.3-alpine

WORKDIR /app

COPY package.json yarn.lock ./

RUN --mount=type=cache,target=/root/.cache/yarn \
    yarn install

CMD ["sh", "-c", "until nc -z $NUXT_DB_HOST $NUXT_DB_PORT; do echo 'Waiting for the database...'; sleep 5; done && yarn && yarn migration:apply && yarn dev"]
# --- AJOUTEZ CES 3 LIGNES POUR FORCER LE DÉMARRAGE ---
ENV HOST=0.0.0.0
ENV PORT=10000
ENV NUXT_PUBLIC_API_BASE=https://ats-1-ssno.onrender.com

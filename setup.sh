#!/usr/bin/env bash
set -e

BACKEND_REPO="git@github.com:mistahuman/fastapi-starter.git"
UI_REPO="git@github.com:mistahuman/sveltekit-skeleton-starter.git"

echo "==> Setting up fullstack-webapp-starter"

if [ ! -d "backend" ]; then
    echo "--> Cloning backend..."
    git clone "$BACKEND_REPO" backend
    rm -rf backend/.git
else
    echo "--> backend/ already exists, skipping"
fi

if [ ! -d "ui" ]; then
    echo "--> Cloning UI..."
    git clone "$UI_REPO" ui
    rm -rf ui/.git
else
    echo "--> ui/ already exists, skipping"
fi

echo ""
echo "==> Done. Next steps:"
echo "    1. cp env.sample .env            (mongo credentials)"
echo "    2. cp backend/env.sample backend/.env"
echo "    3. cp ui/env.sample ui/.env"
echo "    4. make up"

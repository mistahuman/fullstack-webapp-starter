#!/usr/bin/env bash
set -e

UI_REPO="git@github.com:mistahuman/sveltekit-skeleton-starter.git"

echo "==> Setting up fullstack-webapp-starter"
echo ""
echo "Choose a backend:"
echo "  1) FastAPI + MongoDB  (Python)"
echo "  2) Gin + MongoDB      (Go)"
echo "  3) Axum + MongoDB     (Rust)"
echo ""
read -rp "Backend [1/2/3, default: 1]: " choice

case "${choice:-1}" in
  2)
    BACKEND_REPO="git@github.com:mistahuman/gin-mongodb-starter.git"
    echo "--> Using Gin + MongoDB backend"
    ;;
  3)
    BACKEND_REPO="git@github.com:mistahuman/axum-mongodb-starter.git"
    echo "--> Using Axum + MongoDB backend"
    ;;
  *)
    BACKEND_REPO="git@github.com:mistahuman/fastapi-mongodb-starter.git"
    echo "--> Using FastAPI + MongoDB backend"
    ;;
esac

echo ""

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
echo "    5. delete row .gitignore to include into commits"

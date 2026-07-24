# fullstack-webapp-starter

Monorepo shell that wires a backend, a SvelteKit frontend, MongoDB and an Nginx
reverse proxy together with Docker Compose. `make init` clones the backend of your
choice and the UI; this repo only tracks the orchestration layer.

## Stack

Docker Compose · Nginx · MongoDB 8 · SvelteKit UI · FastAPI, Gin or Axum backend

## Run

```bash
make init                            # pick a backend, clone backend/ and ui/
cp env.sample .env                   # MongoDB root credentials
cp backend/env.sample backend/.env
cp ui/env.sample ui/.env
make up                              # -> http://localhost
```

Requires Docker, Docker Compose, and an SSH key configured for GitHub.

To switch backend: delete `backend/` and re-run `make init`.

## Configuration

| File | What goes in it |
|---|---|
| `.env` | MongoDB root credentials |
| `backend/.env` | `MONGO_URI`, `MONGO_DB`, backend name and version |
| `ui/.env` | `VITE_API_URL` — backend base URL |

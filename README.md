# fullstack-webapp-starter

Monorepo shell that wires together a backend, SvelteKit frontend, MongoDB, and Nginx reverse proxy — all via Docker Compose.

## Stack

| Service  | Source                                                                                                              |
| -------- | ------------------------------------------------------------------------------------------------------------------- |
| MongoDB  | `mongo:8`                                                                                                           |
| Backend  | [fastapi-mongodb-starter](https://github.com/mistahuman/fastapi-mongodb-starter) · [gin-mongodb-starter](https://github.com/mistahuman/gin-mongodb-starter) · [axum-mongodb-starter](https://github.com/mistahuman/axum-mongodb-starter) |
| UI       | [sveltekit-skeleton-starter](https://github.com/mistahuman/sveltekit-skeleton-starter)                             |
| Nginx    | `nginx:alpine`                                                                                                      |

## Prerequisites

- Docker + Docker Compose
- SSH key configured for GitHub (the setup script clones via SSH)

## Getting started

```bash
# 1. Clone this repo
git clone git@github.com:mistahuman/fullstack-webapp-starter.git
cd fullstack-webapp-starter

# 2. Clone backend and UI (you'll be asked which backend to use)
make init

# 3. Configure environment files
cp env.sample .env                   # MongoDB root credentials
cp backend/env.sample backend/.env  # Backend-specific env
cp ui/env.sample ui/.env            # UI-specific env

# 4. Start the stack
make up
```

The app is available at **http://localhost**.

## Backend options

`make init` prompts you to choose between:

| Option | Backend | Language |
| ------ | ------- | -------- |
| 1 (default) | FastAPI + Beanie | Python 3.13 |
| 2 | Gin + mongo-driver | Go 1.23 |
| 3 | Axum + mongodb driver | Rust 1.87 |

Both backends expose the same REST API contract on port 8000, so the frontend and Nginx config work unchanged with either.

## Routing

Nginx handles all incoming traffic on port 80:

| Path     | Service                                           |
| -------- | ------------------------------------------------- |
| `/api/*` | Backend (`:8000`, `/api` prefix stripped)         |
| `/*`     | SvelteKit UI (`:3000`)                            |

## Make targets

| Target       | Description                      |
| ------------ | -------------------------------- |
| `make init`  | Clone backend and UI repos       |
| `make up`    | Start all services in background |
| `make down`  | Stop all services                |
| `make build` | Rebuild Docker images            |
| `make logs`  | Follow logs from all services    |
| `make ps`    | Show running service status      |

## How `make init` works

`setup.sh` prompts for a backend choice, clones the selected backend and the UI into `backend/` and `ui/`, then removes their `.git` directories so they become plain source directories. Both are gitignored — this repo only tracks the orchestration layer (Compose, Nginx, Makefile).

> **To switch backend or update:** delete the `backend/` directory and re-run `make init`.

## UI adapter strategy

The UI uses two SvelteKit adapters depending on the build context:

| Context               | Adapter          | How it's triggered                                  |
| --------------------- | ---------------- | --------------------------------------------------- |
| Docker (`make build`) | `adapter-node`   | `DOCKER_BUILD=true` set in `ui/Dockerfile`          |
| GitHub Actions CI     | `adapter-static` | `DOCKER_BUILD` not set → GitHub Pages output        |

## Project structure

```
fullstack-webapp-starter/
├── docker-compose.yml   # Service definitions
├── Makefile             # Convenience targets
├── setup.sh             # Clones backend (choice) and UI
├── env.sample           # MongoDB credentials template → copy to .env
├── nginx/
│   └── nginx.conf       # Reverse proxy config
└── .gitignore           # Ignores .env, backend/, ui/
```

# fullstack-webapp-starter — Claude Code context

Orchestration shell only. This repo tracks Compose, Nginx and the Makefile —
`backend/` and `ui/` are cloned in and gitignored.

## Commands

```bash
make init    # clone backend (prompted choice) and ui
make up      # start everything in background -> http://localhost
make down    # stop
make build   # rebuild images
make logs    # follow logs
make ps      # service status
```

## How `make init` works

`setup.sh` asks which backend to use, clones it into `backend/` and the UI into
`ui/`, then **deletes their `.git` directories** so they become plain source trees.
To switch backend or pull updates: delete `backend/` and re-run `make init`.

| Choice | Backend | Language |
|---|---|---|
| 1 (default) | FastAPI + Beanie | Python 3.13 |
| 2 | Gin + mongo-driver | Go 1.23 |
| 3 | Axum + mongodb driver | Rust 1.87 |

All three expose the same REST contract on port 8000, so Nginx and the frontend
work unchanged with any of them.

## Routing

Nginx owns port 80:

| Path | Goes to |
|---|---|
| `/api/*` | backend `:8000`, `/api` prefix stripped |
| `/*` | SvelteKit UI `:3000` |

## UI adapter strategy

The UI switches SvelteKit adapter based on `DOCKER_BUILD`:

| Context | Adapter | Trigger |
|---|---|---|
| Docker (`make build`) | `adapter-node` | `DOCKER_BUILD=true` set in `ui/Dockerfile` |
| GitHub Actions CI | `adapter-static` | `DOCKER_BUILD` unset → GitHub Pages output |

This is why the same UI repo can be both a Pages site and a container.

## Prerequisites

Docker, Docker Compose, and an SSH key configured for GitHub — `setup.sh` clones
over SSH.

# Airmesh Control Server

Minimal control server for the Airmesh MVP.

It handles:

- content-addressed `.blend` blob upload
- render manifest creation
- render job creation
- worker registration and heartbeat
- worker task assignment
- result upload
- JSON-line operational logs

The server is intentionally compact. Runtime state is in memory. Blob, result, and log files are stored on disk.

## Run

```bash
npm install
npm start
```

Docker:

```bash
docker compose up --build
```

The Docker compose file publishes the server on port 8080:

```text
8080:8080
```

Put Express/Nginx/Caddy in front of it to expose:

```text
https://gengine.co.kr/airmesh
```

If the worker runs in Docker on the same host, use the host-reachable URL:

```text
http://host.docker.internal:8080
```

## Storage

Default local paths:

```text
storage/blobs/
storage/results/
storage/logs/control-server.log
storage/tmp/
```

Inside Docker:

```text
/data/blobs/
/data/results/
/data/logs/control-server.log
/data/tmp/
```

## Important Logs

The server writes JSON lines to `storage/logs/control-server.log`.

Important events:

- `render.job.created`
- `worker.registered`
- `render.task.assigned`
- `render.task.completed`
- `render.task.failed`

## API

```text
GET  /health
POST /api/bundles/check
POST /api/blobs
GET  /api/blobs/:hash
POST /api/manifests
POST /api/jobs
GET  /api/jobs
GET  /api/jobs/:jobId
GET  /api/jobs/:jobId/result
POST /api/workers/register
GET  /api/workers
POST /api/workers/:workerId/heartbeat
POST /api/workers/:workerId/tasks/next
POST /api/workers/:workerId/tasks/:taskId/result
POST /api/workers/:workerId/tasks/:taskId/fail
```

## Current Limits

- No database yet.
- No authentication yet.
- No tile merge yet.
- No animation workflow yet.
- Jobs and workers disappear when the process restarts.

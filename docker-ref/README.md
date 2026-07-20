# Docker Revision Notes

## 1. Image vs Container

### Image
- Read-only blueprint/template.
- Contains application code, dependencies, libraries and metadata.
- Not running.
- Used to create containers.

### Container
- Running instance of an image.
- Isolated process running on the host OS.
- Has its own filesystem, network and process space.
- Lives until its main process (PID 1) exits.

---

## 2. What `docker run` does

High-level flow:

1. Looks for the requested image locally.
2. If not found, pulls the requested image/tag from Docker Hub (or configured registry).
3. Creates a new writable container from the image.
4. Configures networking, volumes, environment variables, etc.
5. Starts the container.

---

## 3. Dockerfile

A Dockerfile is a blueprint for building Docker images.

- Declarative instructions.
- Built layer-by-layer.
- Layers are cached.
- Reusing cached layers significantly speeds up image builds.

---

## 4. Why Docker is lighter than Virtual Machines

### Virtual Machine

- Virtualizes hardware.
- Runs a complete Guest OS.
- Requires a Hypervisor.
- Larger disk usage.
- Higher RAM usage.
- Slower startup.

### Docker

- Virtualizes processes.
- Shares the Host OS kernel.
- Runs isolated processes.
- Lightweight.
- Fast startup.
- Lower resource usage.

---

## 5. `docker ps -a`

Shows every container:

- Running
- Exited
- Stopped
- Created

---

# Docker Images

## Image Layers

Docker images are built in layers.

Every instruction like:

- RUN
- COPY
- ADD

creates a new filesystem layer.

Benefits:

- Cache reuse
- Faster builds
- Shared layers across multiple images

---

## Layer Caching

If previous layers haven't changed:

Docker reuses cached layers instead of rebuilding them.

Example:

```dockerfile
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
```

Changing application code only rebuilds the last layer.

Dependencies remain cached.

---

## Image Tags

Tags represent versions of an image.

Examples:

```
python:3.13
node:22
ubuntu:24.04
myapp:v1
```

If no tag is specified:

```
latest
```

is used by default.

---

## `.dockerignore`

Purpose:

Prevent unnecessary files from being copied into the build context.

Common examples:

```
node_modules/
.git/
.venv/
__pycache__/
.env
```

Benefits:

- Smaller build context
- Smaller images
- Faster builds
- Better caching

---

## `docker image prune`

Removes unused/dangling images.

Does **not** remove images currently being used by containers.

---

# Containers

## `docker stop` vs `docker kill`

### docker stop

Graceful shutdown.

Flow:

```
SIGTERM
↓
(wait)
↓
SIGKILL
```

Allows the application to clean up resources.

---

### docker kill

Immediately sends:

```
SIGKILL
```

No graceful shutdown.

---

## `docker exec`

Runs a command inside an already running container.

Example:

```bash
docker exec -it my-container bash
```

---

## `-it`

Combination of:

```
-i
```

Interactive input

and

```
-t
```

Allocate a pseudo-terminal.

Commonly used for interactive shells.

---

## `docker logs -f`

Streams container logs live.

Equivalent to:

```
tail -f
```

for Docker logs.

---

## PID 1

The main process inside a container.

Important rule:

> If PID 1 exits, the container exits.

A container only lives while its main process is running.

---

# Networking

## EXPOSE vs `-p`

### EXPOSE

Inside Dockerfile.

Acts as documentation/metadata.

Does **not** publish ports.

Example:

```dockerfile
EXPOSE 8000
```

---

### `-p`

Actually publishes ports.

Example:

```bash
docker run -p 8000:8000 image
```

Meaning:

```
Host Port : Container Port
```

---

## Default Network

Docker automatically creates a:

```
bridge
```

network.

Containers on the same bridge network can communicate with each other.

---

# Volumes

Containers have their own writable filesystem.

Deleting the container deletes that writable filesystem.

Volumes solve this problem.

Benefits:

- Persistent data
- Shared data
- Independent of container lifecycle

---

## Bind Mount

Maps a specific host directory into the container.

Example:

```
Host:

~/project

↓

Container:

/app
```

Unlike Docker volumes, you choose the exact host directory.

---

# Optimization (To Learn)

## Reduce Image Size

- Multi-stage builds
- Use slim/alpine/distroless images
- Remove unnecessary packages
- Ignore unnecessary files using `.dockerignore`
- Keep dependency layers clean

---

## Improve Build Caching

- Copy dependency files before application code.
- Install dependencies before copying the rest of the project.
- Avoid invalidating cached layers unnecessarily.
- Keep frequently changing files near the end of the Dockerfile.

---

# Topics Left to Learn

- Dockerfile instructions
  - FROM
  - WORKDIR
  - COPY
  - ADD
  - RUN
  - CMD
  - ENTRYPOINT
  - ENV
  - ARG
  - USER

- Multi-stage builds

- Image optimization

- Distroless images

- Docker Compose

- Health checks

- Writing production Dockerfiles for:
  - Python
  - Node.js
  - Go
  - Java

# ---------------------------
# Stage 1: Build Stage
# ---------------------------
FROM ubuntu:22.04 AS builder

RUN apt update && apt install -y \
    build-essential \
    cmake \
    libgtest-dev \
    git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN cmake -S . -B build && \
    cmake --build build && \
    ctest --test-dir build

# ---------------------------
# Stage 2: Runtime Stage
# ---------------------------
FROM ubuntu:22.04

WORKDIR /app

# Copy only compiled binary from builder
COPY --from=builder /app/build/app .

CMD ["./app"]

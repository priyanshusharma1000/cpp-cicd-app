FROM ubuntu:22.04

RUN apt update && apt install -y \
    build-essential \
    cmake \
    libgtest-dev \
    git

WORKDIR /app

COPY . .

RUN rm -rf build && \
    cmake -S . -B build && \
    cmake --build build && \
    ctest --test-dir build

CMD ["./build/app"]

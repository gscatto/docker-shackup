FROM alpine as builder
RUN apk add git && git clone https://github.com/gscatto/shackup.git /shackup

FROM debian:12.4
RUN apt-get update && \
    apt-get install -y --no-install-recommends rsync && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /shackup/src/main/* /bin
ENV \
    CHECKSUM_CALCULATE='xargs -0 sha1sum' \
    CHECKSUM_CHECK='sha1sum -c --quiet' \
    COMPRESSION_COMPRESS='gzip -9' \
    COMPRESSION_DECOMPRESS='gzip -d' \

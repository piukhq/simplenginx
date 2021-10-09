FROM nginx:latest as build

RUN mkdir -p /build/etc/nginx && \
    mkdir -p /build/var/cache/nginx && \
    cp -a --parents /etc/passwd /build && \
    cp -a --parents /etc/group /build && \
    cp -a --parents /var/log/nginx /build && \
    cp -a --parents /lib/*-linux-gnu/libpcre.so.* /build && \
    cp -a --parents /lib/*-linux-gnu/libz.so.* /build && \
    cp -a --parents /usr/sbin/nginx /build

ADD nginx.conf /build/etc/nginx/

FROM gcr.io/distroless/base-debian10

COPY --from=build /build /

ENTRYPOINT ["nginx", "-g", "daemon off;"]

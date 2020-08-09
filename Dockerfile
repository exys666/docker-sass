FROM alpine:3.12 AS build

RUN apk --update add git build-base
RUN git clone https://github.com/sass/sassc

WORKDIR /sassc

RUN git clone https://github.com/sass/libsass
RUN SASS_LIBSASS_PATH=/sassc/libsass make

FROM alpine:3.12
COPY --from=build /sassc/bin/sassc /usr/bin/sass

RUN apk add --no-cache libstdc++

ENTRYPOINT [ "sass" ]


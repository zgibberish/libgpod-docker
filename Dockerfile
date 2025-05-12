FROM debian:bookworm AS build

# base deps
RUN apt-get update && apt-get install -y \
    gcc \
    musl-dev \
    make \
    automake \
    gettext \
    gtk-doc-tools \
    intltool \
    libplist-dev \
    pkg-config \
    libglib2.0-dev \
    libsqlite3-dev \
    libxml2-dev \
    libgdk-pixbuf-2.0-dev \
    libimobiledevice-dev

# python deps
RUN apt-get install -y \
	python3 \
	python3-dev \
	python3-mutagen \
	python-gi-dev \
	swig

WORKDIR /libgpod-0.8.3
COPY libgpod-0.8.3 .
RUN ./configure --with-python=/usr/bin/python3 \
    && make \
    && make install

# -----

FROM debian:bookworm AS runtime-py
RUN apt-get update && apt-get install -y \
    python3 \
    python3-gi \
    python3-mutagen \
    libgdk-pixbuf-2.0-0 \
    libimobiledevice6
COPY --from=build '/usr/local/lib/python3.11/site-packages/gpod' '/usr/local/lib/python3.11/site-packages/gpod'
COPY --from=build '/usr/local/lib/libgpod.la' '/usr/local/lib/libgpod.la'
COPY --from=build '/usr/local/lib/libgpod.a' '/usr/local/lib/libgpod.a'
COPY --from=build '/usr/local/lib/libgpod.so.4.3.2' '/usr/local/lib/libgpod.so.4.3.2'
RUN ln -s '/usr/local/lib/libgpod.so.4.3.2' '/usr/local/lib/libgpod.so.4'
RUN ln -s '/usr/local/lib/libgpod.so.4.3.2' '/usr/local/lib/libgpod.so'
ENV PYTHONPATH='/usr/local/lib/python3.11/site-packages'
ENV LD_LIBRARY_PATH='/usr/local/lib'
WORKDIR /

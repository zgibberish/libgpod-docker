# libgpod-docker

Docker container for building the libgpod library (+Python bindings)

I'm using john8675309's fork that has better support for python3

```shell
git clone https://github.com/john8675309/libgpod-0.8.3
```

Build the image (you can either buildx or the legacy builder)

```shell
# build and runtime image
docker buildx build -t libgpod .
# only build environment
docker buildx build -t libgpod --target build .
```

- Compiled libs are inside the image at `/usr/local/libs/libgpod*`
- Python bindings module is at `/usr/local/lib/python3.11/site-packages/gpod`

You can start up a `libgpod` container, and use `docker cp` to copy them out.

This runs a Python script from the host inside a libgpod environment container

```shell
docker run \
    --mount type=bind,src='/run/media/gibberish/GOOBER',dst='/ipodmnt' \
    -v .:/runtime-py \
    -it --rm --name libgpod \
    libgpod script.py
```

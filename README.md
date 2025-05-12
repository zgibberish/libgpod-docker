# libgpod-docker

Docker container for building the libgpod library (+Python3 bindings).

## Building library and python bindings

I'm using john8675309's fork that's supposed to have better support for python3

```shell
git clone https://github.com/john8675309/libgpod-0.8.3
docker build -t libgpod --target build .
mkdir build
mkdir build/lib
docker create --name build_cont libgpod
docker cp build_cont:/usr/local/lib/libgpod.la build/lib/
docker cp build_cont:/usr/local/lib/libgpod.a build/libs
docker cp build_cont:/usr/local/lib/libgpod.so.4.3.2 build/lib/
docker cp build_cont:/usr/local/lib/python3.11/site-packages/gpod build/gpod
docker rm build_cont
```

Example of running a Python script from the host inside a `libgpod` environment container (see `test.py` for more details)

```shell
docker run \
    --mount type=bind,src='/run/media/gibberish/GOOBER',dst='/ipodmnt' \
    -v .:/runtime-py \
    -it --rm --name libgpod \
    libgpod script.py
```

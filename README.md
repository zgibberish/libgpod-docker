# libgpod-docker

Docker image for building libgpod with python3 bindings, no mono bindings cuz I haven't really looked into it.

## Building library and Python bindings

```shell
# I'm using john8675309's fork that's supposed to have better python3 support
git clone https://github.com/john8675309/libgpod-0.8.3

docker build -t libgpod --target build .

mkdir build
mkdir build/lib
docker create --name build_cont libgpod
docker cp 'build_cont:/usr/local/lib/libgpod.la' 'build/lib/'
docker cp 'build_cont:/usr/local/lib/libgpod.a' 'build/lib/'
docker cp 'build_cont:/usr/local/lib/libgpod.so.4.3.2' 'build/lib/'
docker cp 'build_cont:/usr/local/lib/python3.11/site-packages/gpod' 'build/gpod'
docker rm build_cont
```

Example of running a Python script inside a libgpod environment container (see `test.py` and `Dockerfile` for more details). This is just something I quickly put together to test stuff, so it might look a little janky.

```shell
docker build -t libgpod-runtime-py --target runtime-py .
docker create \
	--mount type=bind,src='/run/media/gibberish/GOOBER',dst='/ipodmnt' \
	--rm --name runtime_cont libgpod-runtime-py \
	python3 test.py
docker cp test.py runtime_cont:/
docker start -ia runtime_cont
```

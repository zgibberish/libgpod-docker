# run a python script in the libgpod container
docker run \
    --mount type=bind,src='/run/media/gibberish/GOOBER',dst='/ipodmnt' \
    -v .:/runtime-py \
    -it --rm --name libgpod \
    libgpod $1

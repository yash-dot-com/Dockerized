# environment for running code
FROM debian:stable-slim

# copy final binary from source to destination in container
COPY goserver /bin/goserver

# set envionment for this container 
ENV PORT=8991

# run this command ones container is up
CMD ["./bin/goserver"]


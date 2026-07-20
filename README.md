## Dockerizing Compiled Languages is so easy!

- write code 
- compile code 
- build image from dockerfile (copy binary into container)
- assign ENV variables if any 
- run

## compiling golang for a specific platform 

```bash 
GOOS=<target-os> GOARCH=<target-architecture> go build <file-name>
```

- GOOS : target operating system 
- GOARCH : target machine architecture 



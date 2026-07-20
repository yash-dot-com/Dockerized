### Dockerizing Interpreted languages is not as fun!

- write your code 
- write docker configuration (dockerfile)
    - choose os image
    - update & install build tools
    - download python interpreter source code 
    - unpack python interpreter source code 
    - build the python interpreter from source code & configure it
    - install python packages from requirements.txt
    - copy our code 
    - copy any dependencies like static files etc
    - put commands to run the code
- finally build the image
- run the container 
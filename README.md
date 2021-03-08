# FiveM Windows Docker Example

Requirements:

    - Docker for windows
    - docker-compose 

### Steps
    1. Clone Repository
    2. Configure a `.env` file to your specifications.
    3. Perform the command `docker-compose up` in the base directory
    4. Enjoy your FiveM server running in a Windows Docker container

### .env File
```
DEV_STEAM_API_KEY=
DEV_SV_HOSTNAME=
DEV_SV_LICENSEKEY=
DEV_SV_PORT=
MYSQL_HOST=
MYSQL_USER=
MYSQL_PASSWORD=
MYSQL_PORT=
MYSQL_DB=
```

### Notes
 - Modifying the template.server_dev.cfg will require rebuilding the container with 
`docker-compose up --build`

 - If you wish to access the server console, use `docker attach {container-name}` 
container-name in this example would be "fivem-bare-windows"

 - You may receive errors after running `docker-compose up` concerning invalid characters. This is normal.
 
![img](https://i.gyazo.com/f849cacaf5f04a5d282611117b76260e.png)

 - You can see the logs with `docker-logs {container-name} -f` or attach as explained above

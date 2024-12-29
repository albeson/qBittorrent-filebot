# qBittorrent-filebot

qBittorrent including Filebot tool

For qBittorrent, I used [linuxserver/qbittorrent docker](https://hub.docker.com/r/linuxserver/qbittorrent).

For Filebot, please see https://www.filebot.net


### You can set different variables:

| Variable |  Default value |
| -------- |  ------------- |
| **FILEBOT_LANG** | en
| **FILEBOT_ACTION** | copy
| **FILEBOT_CONFLICT** | auto
| **FILEBOT_ARTWORK** | yes
| **MUSIC_FORMAT** | {plex}
| **MOVIE_FORMAT** | {plex}
| **SERIE_FORMAT** | {plex}
| **ANIME_FORMAT** | animes/{n}/{e.pad(3)} - {t}
| **PUID** | 99
| **PGID** | 100
| **FILES_CHECK_PERM** | no
| **WEBUI** | 8080

### Please READ:

* Add your Filebot license file (psm file) into /data/filebot folder then restart


### Volumes:

- /data : folder for the config
- /downloads : folder for downloads
- /media : folder for media

### Ports:

 - `8080` (WEBUI)
 - `6881` (PORT_RTORRENT)

## Docker Compose
```sh
docker run -d --name='qbittorrent-filebot' \
-e TZ="Europe/London" \
-e MOVIE_FORMAT='movies/{~plex.id}' \
-e SERIE_FORMAT='tvshows/{~plex.id}' \
-e PUID=100 -e PGID=1000 \
-e WEBUI_PORT=8080 \
-v /mnt/user/media:/media:rw \
-v /mnt/user/downloads:/downloads:rw \
-v /mnt/user/appdata/qbittorrent-filebot:/data:rw \
alb/qbittorrent-filebot
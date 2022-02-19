# Playground: Unicorn Graceful Restart under systemd

```sh
docker image build --file ./Dockerfile --tag sample_unicorn_systemd:t01 --rm .
docker rm -f sample_unicorn_systemd
docker container run --detach -it --rm --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name sample_unicorn_systemd sample_unicorn_systemd:t01
docker exec -it sample_unicorn_systemd /bin/bash
```

```sh
systemctl status sample_app.service

curl localhost:8080 -w "\n"

cat unicorn.pid
pstree --show-pids
ps -x -o user,pid,ppid,start,command --forest | grep -e unicorn -e PID | grep -v grep

systemctl reload sample_app.service

cat unicorn.pid
pstree --show-pids
ps -x -o user,pid,ppid,start,command --forest | grep -e unicorn -e PID | grep -v grep
```

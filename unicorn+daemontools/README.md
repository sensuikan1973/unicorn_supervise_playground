# Playground: Unicorn Graceful Restart under daemontools

```sh
docker image build --file ./Dockerfile --tag sample_unicorn_daemontools:t01 --rm .
docker container run -it --rm sample_unicorn_daemontools:t01 /bin/bash
```

```bash
/command/svscanboot &

pstree --show-pids
ps -f -o user,pid,ppid,start,command --forest

svstat /service/sample_server/

curl localhost:8080 -w "\n"

# Graceful Restart
svc -2 /service/sample_server # SIGUSR2 + QUIT to old master. See unicorn.conf.rb
pstree --show-pids
ps -f -o user,pid,ppid,start,command --forest

svstat /service/sample_server/
svstat /service/sample_server/
svstat /service/sample_server/ # => pid が毎回変わってることが確認できる

cat unicorn_stderr.log # => エラーで永遠に失敗してるのがわかる

tai64nlocal < /service/sample_server/log/main/current
```

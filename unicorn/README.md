# Playground: Unicorn Graceful Restart

```sh
docker image build --file ./Dockerfile --tag sample:t01 --rm .
docker container run -it --rm sample:t01 /bin/bash
```

```bash
bundle exec unicorn ./src/config.ru --config-file ./src/unicorn.simple_conf.rb --daemonize

curl localhost:8080 -w "\n"

pstree --show-pids
ps -x -o user,pid,ppid,start,command --forest | grep -e unicorn -e PID | grep -v grep

cat unicorn.pid

# `USR2` シグナルの送信だけで旧プロセスも停止させるような hook を設定することは可能だが、ここではプロセスの状態を確認しやすいよう、明示的にやる。
# See: https://github.com/defunkt/unicorn/blob/93e154e16b87f943a20fa720e002c67c9d17c30b/examples/unicorn.conf.rb#L71
kill -USR2 `cat unicorn.pid`
pstree --show-pids
ps -x -o user,pid,ppid,start,command --forest | grep -e unicorn -e PID | grep -v grep
cat unicorn.pid
kill -QUIT `cat unicorn.pid.oldbin`
pstree --show-pids
ps -x -o user,pid,ppid,start,command --forest | grep -e unicorn -e PID | grep -v grep
```

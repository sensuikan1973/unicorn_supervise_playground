# Playground: Unicorn Graceful Restart under p5-Server-Starter under daemontools

```sh
docker image build --file ./Dockerfile --tag sample_unicorn_server-starter:t01 --rm .
docker container run -it --rm sample_unicorn_server-starter:t01 /bin/bash
```

```bash
/command/svscanboot &

svc -h /service/sample_server # 即 HUP を打ってみる。bundle install を run から切り離せば待つ必要もなくなる。

svstat /service/sample_server/

pstree --show-pids
ps -f -o user,pid,ppid,start,command --forest

cat unicorn_stderr.log
cat unicorn_stdout.log

tai64nlocal < /service/sample_server/log/main/current
```

### 結果例

```log
root@47cd46c66784:/sample# tai64nlocal < /service/sample_server/log/main/current | grep start_server -A 10
2022-02-18 08:31:23.237055500 start_server (pid:326) starting now...
2022-02-18 08:31:23.238142500 starting new worker 592
2022-02-18 08:31:28.991692500 received HUP, spawning a new worker
2022-02-18 08:31:28.992160500 starting new worker 601
2022-02-18 08:31:29.996245500 new worker is now running, sending QUIT to old workers:592
2022-02-18 08:31:29.996245500 sleeping 100 secs before killing old workers
2022-02-18 08:33:09.933859500 killing old workers
2022-02-18 08:33:09.933953500 old worker 592 died, status:0
```

```log
root@47cd46c66784:/sample# cat unicorn_stderr.log
I, [2022-02-18T08:31:23.461519 #592]  INFO -- : inherited addr=/sample/unicorn.sock fd=4
I, [2022-02-18T08:31:23.461608 #592]  INFO -- : Refreshing Gem list
I, [2022-02-18T08:31:24.473761 #593]  INFO -- : worker=0 ready
I, [2022-02-18T08:31:25.480121 #595]  INFO -- : worker=1 ready
I, [2022-02-18T08:31:26.482959 #597]  INFO -- : worker=2 ready
I, [2022-02-18T08:31:27.484877 #598]  INFO -- : worker=3 ready
I, [2022-02-18T08:31:28.470886 #599]  INFO -- : worker=4 ready
I, [2022-02-18T08:31:29.212151 #601]  INFO -- : inherited addr=/sample/unicorn.sock fd=4
I, [2022-02-18T08:31:29.212231 #601]  INFO -- : Refreshing Gem list
I, [2022-02-18T08:31:29.472998 #602]  INFO -- : worker=5 ready
I, [2022-02-18T08:31:30.223256 #604]  INFO -- : worker=0 ready
I, [2022-02-18T08:31:30.474109 #605]  INFO -- : worker=6 ready
I, [2022-02-18T08:31:31.229106 #606]  INFO -- : worker=1 ready
I, [2022-02-18T08:31:31.476540 #607]  INFO -- : worker=7 ready
I, [2022-02-18T08:31:32.231580 #608]  INFO -- : worker=2 ready
I, [2022-02-18T08:31:32.478037 #609]  INFO -- : worker=8 ready
I, [2022-02-18T08:31:33.233978 #610]  INFO -- : worker=3 ready
I, [2022-02-18T08:31:33.479339 #611]  INFO -- : worker=9 ready
I, [2022-02-18T08:31:34.236632 #612]  INFO -- : worker=4 ready
I, [2022-02-18T08:31:34.480501 #613]  INFO -- : worker=10 ready
I, [2022-02-18T08:31:35.244125 #614]  INFO -- : worker=5 ready
I, [2022-02-18T08:31:35.483051 #615]  INFO -- : worker=11 ready
I, [2022-02-18T08:31:36.248951 #616]  INFO -- : worker=6 ready
I, [2022-02-18T08:31:36.485388 #617]  INFO -- : worker=12 ready
I, [2022-02-18T08:31:37.250963 #618]  INFO -- : worker=7 ready
I, [2022-02-18T08:31:37.487495 #619]  INFO -- : worker=13 ready
I, [2022-02-18T08:31:38.253185 #620]  INFO -- : worker=8 ready
I, [2022-02-18T08:31:38.488686 #621]  INFO -- : worker=14 ready
I, [2022-02-18T08:31:39.255847 #623]  INFO -- : worker=9 ready
I, [2022-02-18T08:31:39.490106 #624]  INFO -- : worker=15 ready
I, [2022-02-18T08:31:40.258105 #625]  INFO -- : worker=10 ready
I, [2022-02-18T08:31:40.491594 #626]  INFO -- : worker=16 ready
I, [2022-02-18T08:31:41.261037 #627]  INFO -- : worker=11 ready
I, [2022-02-18T08:31:41.493270 #628]  INFO -- : worker=17 ready
I, [2022-02-18T08:31:42.263224 #629]  INFO -- : worker=12 ready
I, [2022-02-18T08:31:42.494892 #630]  INFO -- : worker=18 ready
I, [2022-02-18T08:31:43.265231 #631]  INFO -- : worker=13 ready
I, [2022-02-18T08:31:43.496380 #632]  INFO -- : worker=19 ready
I, [2022-02-18T08:31:44.267613 #633]  INFO -- : worker=14 ready
I, [2022-02-18T08:31:44.497784 #634]  INFO -- : worker=20 ready
I, [2022-02-18T08:31:45.269862 #636]  INFO -- : worker=15 ready
I, [2022-02-18T08:31:45.499256 #637]  INFO -- : worker=21 ready
I, [2022-02-18T08:31:46.272096 #638]  INFO -- : worker=16 ready
I, [2022-02-18T08:31:46.500759 #639]  INFO -- : worker=22 ready
I, [2022-02-18T08:31:47.274400 #640]  INFO -- : worker=17 ready
I, [2022-02-18T08:31:47.502027 #641]  INFO -- : worker=23 ready
I, [2022-02-18T08:31:48.276360 #642]  INFO -- : worker=18 ready
I, [2022-02-18T08:31:48.503138 #643]  INFO -- : worker=24 ready
I, [2022-02-18T08:31:49.279334 #644]  INFO -- : worker=19 ready
I, [2022-02-18T08:31:49.505107 #645]  INFO -- : worker=25 ready
I, [2022-02-18T08:31:50.282006 #646]  INFO -- : worker=20 ready
I, [2022-02-18T08:31:50.506451 #647]  INFO -- : worker=26 ready
I, [2022-02-18T08:31:51.284508 #648]  INFO -- : worker=21 ready
I, [2022-02-18T08:31:51.508247 #649]  INFO -- : worker=27 ready
I, [2022-02-18T08:31:52.286523 #650]  INFO -- : worker=22 ready
I, [2022-02-18T08:31:52.509271 #651]  INFO -- : worker=28 ready
I, [2022-02-18T08:31:53.288582 #653]  INFO -- : worker=23 ready
I, [2022-02-18T08:31:53.510520 #654]  INFO -- : worker=29 ready
I, [2022-02-18T08:31:54.291145 #656]  INFO -- : worker=24 ready
I, [2022-02-18T08:31:54.513216 #657]  INFO -- : worker=30 ready
I, [2022-02-18T08:31:55.293766 #658]  INFO -- : worker=25 ready
I, [2022-02-18T08:31:55.515098 #659]  INFO -- : worker=31 ready
I, [2022-02-18T08:31:56.296158 #660]  INFO -- : worker=26 ready
I, [2022-02-18T08:31:56.517493 #661]  INFO -- : worker=32 ready
I, [2022-02-18T08:31:57.298975 #662]  INFO -- : worker=27 ready
I, [2022-02-18T08:31:57.520154 #663]  INFO -- : worker=33 ready
I, [2022-02-18T08:31:58.301773 #664]  INFO -- : worker=28 ready
I, [2022-02-18T08:31:58.501008 #665]  INFO -- : worker=34 ready
I, [2022-02-18T08:31:59.283109 #666]  INFO -- : worker=29 ready
I, [2022-02-18T08:31:59.503303 #667]  INFO -- : worker=35 ready
I, [2022-02-18T08:32:00.286617 #668]  INFO -- : worker=30 ready
I, [2022-02-18T08:32:00.505692 #669]  INFO -- : worker=36 ready
I, [2022-02-18T08:32:01.289584 #670]  INFO -- : worker=31 ready
I, [2022-02-18T08:32:01.508669 #671]  INFO -- : worker=37 ready
I, [2022-02-18T08:32:02.293001 #672]  INFO -- : worker=32 ready
I, [2022-02-18T08:32:02.510398 #673]  INFO -- : worker=38 ready
I, [2022-02-18T08:32:03.299397 #674]  INFO -- : worker=33 ready
I, [2022-02-18T08:32:03.512301 #592]  INFO -- : master process ready
I, [2022-02-18T08:32:03.512912 #675]  INFO -- : worker=39 ready
I, [2022-02-18T08:32:03.541357 #592]  INFO -- : reaped #<Process::Status: pid 605 exit 0> worker=6
I, [2022-02-18T08:32:03.541479 #592]  INFO -- : reaped #<Process::Status: pid 607 exit 0> worker=7
I, [2022-02-18T08:32:03.541617 #592]  INFO -- : reaped #<Process::Status: pid 611 exit 0> worker=9
I, [2022-02-18T08:32:03.541682 #592]  INFO -- : reaped #<Process::Status: pid 613 exit 0> worker=10
I, [2022-02-18T08:32:03.541727 #592]  INFO -- : reaped #<Process::Status: pid 615 exit 0> worker=11
I, [2022-02-18T08:32:03.541779 #592]  INFO -- : reaped #<Process::Status: pid 621 exit 0> worker=14
I, [2022-02-18T08:32:03.541835 #592]  INFO -- : reaped #<Process::Status: pid 624 exit 0> worker=15
I, [2022-02-18T08:32:03.541875 #592]  INFO -- : reaped #<Process::Status: pid 628 exit 0> worker=17
I, [2022-02-18T08:32:03.541922 #592]  INFO -- : reaped #<Process::Status: pid 634 exit 0> worker=20
I, [2022-02-18T08:32:03.541963 #592]  INFO -- : reaped #<Process::Status: pid 639 exit 0> worker=22
I, [2022-02-18T08:32:03.542015 #592]  INFO -- : reaped #<Process::Status: pid 645 exit 0> worker=25
I, [2022-02-18T08:32:03.543050 #592]  INFO -- : reaped #<Process::Status: pid 657 exit 0> worker=30
I, [2022-02-18T08:32:03.554937 #592]  INFO -- : reaped #<Process::Status: pid 617 exit 0> worker=12
I, [2022-02-18T08:32:03.555038 #592]  INFO -- : reaped #<Process::Status: pid 632 exit 0> worker=19
I, [2022-02-18T08:32:03.555121 #592]  INFO -- : reaped #<Process::Status: pid 637 exit 0> worker=21
I, [2022-02-18T08:32:03.555190 #592]  INFO -- : reaped #<Process::Status: pid 641 exit 0> worker=23
I, [2022-02-18T08:32:03.555235 #592]  INFO -- : reaped #<Process::Status: pid 647 exit 0> worker=26
I, [2022-02-18T08:32:03.555273 #592]  INFO -- : reaped #<Process::Status: pid 649 exit 0> worker=27
I, [2022-02-18T08:32:03.555332 #592]  INFO -- : reaped #<Process::Status: pid 654 exit 0> worker=29
I, [2022-02-18T08:32:03.555374 #592]  INFO -- : reaped #<Process::Status: pid 659 exit 0> worker=31
I, [2022-02-18T08:32:03.555410 #592]  INFO -- : reaped #<Process::Status: pid 661 exit 0> worker=32
I, [2022-02-18T08:32:03.555528 #592]  INFO -- : reaped #<Process::Status: pid 667 exit 0> worker=35
I, [2022-02-18T08:32:03.556193 #592]  INFO -- : reaped #<Process::Status: pid 609 exit 0> worker=8
I, [2022-02-18T08:32:03.556906 #592]  INFO -- : reaped #<Process::Status: pid 626 exit 0> worker=16
I, [2022-02-18T08:32:03.557052 #592]  INFO -- : reaped #<Process::Status: pid 665 exit 0> worker=34
I, [2022-02-18T08:32:03.557102 #592]  INFO -- : reaped #<Process::Status: pid 669 exit 0> worker=36
I, [2022-02-18T08:32:03.565356 #592]  INFO -- : reaped #<Process::Status: pid 619 exit 0> worker=13
I, [2022-02-18T08:32:03.565438 #592]  INFO -- : reaped #<Process::Status: pid 630 exit 0> worker=18
I, [2022-02-18T08:32:03.565477 #592]  INFO -- : reaped #<Process::Status: pid 643 exit 0> worker=24
I, [2022-02-18T08:32:03.565517 #592]  INFO -- : reaped #<Process::Status: pid 651 exit 0> worker=28
I, [2022-02-18T08:32:03.565617 #592]  INFO -- : reaped #<Process::Status: pid 663 exit 0> worker=33
I, [2022-02-18T08:32:03.565689 #592]  INFO -- : reaped #<Process::Status: pid 671 exit 0> worker=37
I, [2022-02-18T08:32:03.565725 #592]  INFO -- : reaped #<Process::Status: pid 675 exit 0> worker=39
I, [2022-02-18T08:32:03.567901 #592]  INFO -- : reaped #<Process::Status: pid 673 exit 0> worker=38
I, [2022-02-18T08:32:04.301691 #676]  INFO -- : worker=34 ready
I, [2022-02-18T08:32:04.306813 #592]  INFO -- : reaped #<Process::Status: pid 602 exit 0> worker=5
I, [2022-02-18T08:32:05.304866 #677]  INFO -- : worker=35 ready
I, [2022-02-18T08:32:05.309831 #592]  INFO -- : reaped #<Process::Status: pid 599 exit 0> worker=4
I, [2022-02-18T08:32:06.308785 #679]  INFO -- : worker=36 ready
I, [2022-02-18T08:32:06.314034 #592]  INFO -- : reaped #<Process::Status: pid 598 exit 0> worker=3
I, [2022-02-18T08:32:07.312228 #680]  INFO -- : worker=37 ready
I, [2022-02-18T08:32:07.317254 #592]  INFO -- : reaped #<Process::Status: pid 597 exit 0> worker=2
I, [2022-02-18T08:32:08.316086 #682]  INFO -- : worker=38 ready
I, [2022-02-18T08:32:08.321175 #592]  INFO -- : reaped #<Process::Status: pid 595 exit 0> worker=1
I, [2022-02-18T08:32:09.319042 #601]  INFO -- : master process ready
I, [2022-02-18T08:32:09.319558 #684]  INFO -- : worker=39 ready
I, [2022-02-18T08:32:09.420403 #592]  INFO -- : reaped #<Process::Status: pid 593 exit 0> worker=0
I, [2022-02-18T08:32:09.420573 #592]  INFO -- : master complete
```

```log
root@47cd46c66784:/sample# cat unicorn_stdout.log
old_gen 0, old_pid: 
old_gen 0, old_pid: 
old_gen 0, old_pid: 
old_gen 0, old_pid: 
old_gen 0, old_pid: 
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 0, old_pid: 
old_gen 1, old_pid: 592
old_gen 1, old_pid: 592
old_gen 1, old_pid: 592
old_gen 1, old_pid: 592
old_gen 1, old_pid: 592
old_gen 1, old_pid: 592
```

```sh
root@47cd46c66784:/sample# ps -f -o user,pid,ppid,start,command --forest
USER       PID  PPID  STARTED COMMAND
root         1     0 08:31:01 /bin/bash
root        13     1 08:31:06 /bin/sh /command/svscanboot
root        15    13 08:31:06  \_ svscan /service
root        17    15 08:31:06  |   \_ supervise sample_server
root       326    17 08:31:14  |   |   \_ /usr/bin/perl /usr/local/bin/start_server --path=/sample/unicorn.sock --signal-on-term=QUIT --signal-on-hup=QUIT --status-file=/sample/sample_server.status --pid-file=/sample/sampl
root       601   326 08:31:28  |   |       \_ unicorn master /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       604   601 08:31:29  |   |           \_ unicorn worker[0] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       606   601 08:31:30  |   |           \_ unicorn worker[1] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       608   601 08:31:31  |   |           \_ unicorn worker[2] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       610   601 08:31:32  |   |           \_ unicorn worker[3] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       612   601 08:31:33  |   |           \_ unicorn worker[4] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       614   601 08:31:34  |   |           \_ unicorn worker[5] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       616   601 08:31:35  |   |           \_ unicorn worker[6] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       618   601 08:31:36  |   |           \_ unicorn worker[7] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       620   601 08:31:37  |   |           \_ unicorn worker[8] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       623   601 08:31:38  |   |           \_ unicorn worker[9] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       625   601 08:31:39  |   |           \_ unicorn worker[10] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       627   601 08:31:40  |   |           \_ unicorn worker[11] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       629   601 08:31:41  |   |           \_ unicorn worker[12] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       631   601 08:31:42  |   |           \_ unicorn worker[13] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       633   601 08:31:43  |   |           \_ unicorn worker[14] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       636   601 08:31:44  |   |           \_ unicorn worker[15] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       638   601 08:31:45  |   |           \_ unicorn worker[16] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       640   601 08:31:46  |   |           \_ unicorn worker[17] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       642   601 08:31:47  |   |           \_ unicorn worker[18] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       644   601 08:31:48  |   |           \_ unicorn worker[19] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       646   601 08:31:49  |   |           \_ unicorn worker[20] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       648   601 08:31:50  |   |           \_ unicorn worker[21] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       650   601 08:31:51  |   |           \_ unicorn worker[22] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       653   601 08:31:52  |   |           \_ unicorn worker[23] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       656   601 08:31:53  |   |           \_ unicorn worker[24] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       658   601 08:31:54  |   |           \_ unicorn worker[25] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       660   601 08:31:55  |   |           \_ unicorn worker[26] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       662   601 08:31:56  |   |           \_ unicorn worker[27] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       664   601 08:31:57  |   |           \_ unicorn worker[28] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       666   601 08:31:58  |   |           \_ unicorn worker[29] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       668   601 08:31:59  |   |           \_ unicorn worker[30] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       670   601 08:32:00  |   |           \_ unicorn worker[31] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       672   601 08:32:01  |   |           \_ unicorn worker[32] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       674   601 08:32:02  |   |           \_ unicorn worker[33] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       676   601 08:32:03  |   |           \_ unicorn worker[34] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       677   601 08:32:04  |   |           \_ unicorn worker[35] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       679   601 08:32:05  |   |           \_ unicorn worker[36] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       680   601 08:32:06  |   |           \_ unicorn worker[37] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       682   601 08:32:07  |   |           \_ unicorn worker[38] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root       684   601 08:32:08  |   |           \_ unicorn worker[39] /sample/src/config.ru --config-file /sample/src/unicorn.production.rb
root        18    15 08:31:06  |   \_ supervise log
root        20    18 08:31:06  |       \_ multilog t ./main
root        16    13 08:31:06  \_ readproctitle service errors: ..............................................................................................................................................................
root       716     1 08:34:53 ps -f -o user,pid,ppid,start,command --forest
```

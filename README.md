# resque_sigterm
==============

Start redis

```
foreman start
```

Launch worker 

```
./start_resque_worker.sh
```

Put en queue job

```
./start.rb 
```

And try QUIT or TERM

```
./watch_and_kill.rb
```

```
** Waiting for *
** Checking worker
** Found job on worker
** got: (Job{worker} | MyWorker | ["5345180684650cc199e086a405b7f455", {"person"=>"Judas Iscariote", "length"=>5}])
** Forked 82305 at 1355854132
** Processing worker since 1355854132

Time to live => 5 secondes
Yeah i'm alive!!!
Judas Iscariote you're my friend!
....** Exiting...
** Sending TERM signal to child 82305
O_o someone want to kill me :(...
..You've 1 frags!
I'm Jesus of Nazareth i can't died!
** done: (Job{worker} | MyWorker | ["5345180684650cc199e086a405b7f455", {"person"=>"Judas Iscariote", "length"=>5}])
```

Relaunch worker

```
./start_resque_worker.sh
```

Output

```
** Checking worker
** Found job on worker
** got: (Job{worker} | MyWorker | ["4b27fcace7348947810072fe955a8fc3", {"person"=>"Judas Iscariote", "length"=>5}])
** Processing worker since 1355854315
** Forked 82453 at 1355854315
Time to live => 5 secondes
RESURRECTION! Thanks Dad (You're died 1 times)
Yeah i'm alive!!!
Judas Iscariote you're my friend!
.....bye bye...
** done: (Job{worker} | MyWorker | ["4b27fcace7348947810072fe955a8fc3", {"person"=>"Judas Iscariote", "length"=>5}])
** Checking worker

```

And after 3 times

```
** Checking worker
** Found job on worker
** got: (Job{worker} | MyWorker | ["95daeff4670eac3da3f66b6ba97ff927", {"person"=>"Judas Iscariote", "length"=>5}])
** Forked 82670 at 1355854502
** Processing worker since 1355854502
Time to live => 5 secondes
RESURRECTION! Thanks Dad (You're died 3 times)
Yeah i'm alive!!!
Judas Iscariote you're my friend!
....** Exiting...
** Sending TERM signal to child 82670
O_o someone want to kill me :(...
..Omar m'a tuer...
** done: (Job{worker} | MyWorker | ["95daeff4670eac3da3f66b6ba97ff927", {"person"=>"Judas Iscariote", "length"=>5}])
```

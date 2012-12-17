resque_sigterm
==============

Start redis

```
foreman start
```

Launch worker 

```
env VVERBOSE=1 INTERVAL=1 PIDFILE=resque.pid QUEUE=* TERM_CHILD=1 RESQUE_TERM_TIMEOUT=15 bundle exec rake resque:work
```

Put en queue job

```
ruby start.rb 
```

And kill the worker Ctrl-C

```
got: (Job{worker} | MyWorker | [])
resque-1.23.0: Processing worker since 1355760012
resque-1.23.0: Forked 32322 at 1355760012
Yeah i'm alive!!!
.^C** Exiting...
** Sending TERM signal to child 32322
O_o someone want to kill me :(...
.....** done: (Job{worker} | MyWorker | [])
```

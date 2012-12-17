# resque_sigterm
==============

Start redis

```
foreman start
```

Launch worker 

```
env VVERBOSE=1 INTERVAL=1 PIDFILE=resque.pid QUEUE=* TERM_CHILD=1 RESQUE_TERM_TIMEOUT=5 bundle exec rake resque:work
```

Put en queue job

```
ruby start.rb 
```

And try QUIT or TERM

```
3       QUIT (quit)
15      TERM (software termination signal)
```

QUIT (quit)
```
ruby start.rb && sleep 2 && kill -3 `cat resque.pid`
```

TERM (software termination signal)
```
ruby start.rb && sleep 2 && kill -15 `cat resque.pid`
```

Output

```
** 36771: got: (Job{worker} | MyWorker | [])
** 36771: resque-1.23.0: Forked 36781 at 1355762515
** 36781: resque-1.23.0: Processing worker since 1355762515
Yeah i'm alive!!!
..** 36771: Exiting...
** 36771: Sending TERM signal to child 36781
O_o someone want to kill me :(...
......** 36771: Sending KILL signal to child 36781
```

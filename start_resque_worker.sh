#!/usr/bin/env bash

env VVERBOSE=1 INTERVAL=2 PIDFILE=resque.pid QUEUE=* TERM_CHILD=1 RESQUE_TERM_TIMEOUT=5 bundle exec rake resque:work
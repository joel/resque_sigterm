#!/usr/bin/env ruby
require 'rubygems'
File.expand_path('Gemfile', __FILE__)

require 'bundler/setup'
require 'resque'

require File.expand_path('../safe_worker.rb', __FILE__)

begin
  puts 'Set Resque redis'
  uri = URI.parse 'redis://localhost:6379'
  _redis = Redis.new host: uri.host, port: uri.port
  Resque.redis = Redis::Namespace.new :resque, redis: _redis

  puts 'Enqueue Safe Job'
  Resque.enqueue SafeWorker, 'Judas Iscariote'
end
#!/usr/bin/env ruby
require 'rubygems'
File.expand_path('Gemfile', __FILE__)
require 'bundler/setup'
require 'resque'

begin 
  puts "Resque.redis.flushall"
  Resque.redis.flushall
end

#!/usr/bin/env ruby
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
require File.expand_path('../myworker.rb', __FILE__)

begin
  puts "Enqueue Job"
  Resque.enqueue MyWorker
end
#!/usr/bin/env ruby
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
Dir[ File.expand_path('../*.rb', __FILE__) ].each { |f| require f }

begin
  puts 'Enqueue Job'
  Resque.enqueue MyWorker, 'Jean-Baptiste Emanuel ZORG'
end
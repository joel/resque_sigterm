#!/usr/bin/env ruby
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
Dir[ File.expand_path('../*.rb', __FILE__) ].each { |f| require f }

begin
  puts 'Enqueue Job'
  job_id = MyWorker.create person: 'Judas Iscariote'
  status = Resque::Plugins::Status::Hash.get(job_id)
  puts "Status pct_complete => #{status.pct_complete}"
  puts "Status status => #{status.status}" #=> 'queued'
  puts "Status queued? => #{status.queued?}" #=> true
  puts "Status working? => #{status.working?}" #=> false
  puts "Status time => #{status.time}" #=> Time object        
  puts "Status message => #{status.message}" #=> "Created at ..."
  puts "Status num => #{status.num}" #=> 5
  puts "Status total => #{status.total}" # => 100
  
  sleep 2
  if File.exists? 'resque.pid'
    puts 'Send SigTerm'
    system "kill -15 `cat resque.pid`"
  else
    puts 'please start worker first'
  end
end
#!/usr/bin/env ruby
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'resque'
require File.expand_path('../myworker.rb', __FILE__)

class Start
  
  def initialize
    prng = Random.new
    job_id = MyWorker.create person: 'Judas Iscariote', length: prng.rand(4..8) 
    puts "job_id => #{job_id}"
    while status = Resque::Plugins::Status::Hash.get(job_id) and !status.completed? && !status.failed?
      sleep 1
      print status
    end
  end
  
  def print status
    puts '+ -------------------------------------------------- +'
    puts "+ #{Time.now}"
    puts '+ -------------------------------------------------- +'
    
    puts "Status pct_complete => #{status.pct_complete}"
    puts "Status status => #{status.status}" #=> 'queued'
    puts "Status queued? => #{status.queued?}" #=> true
    puts "Status working? => #{status.working?}" #=> false
    puts "Status time => #{status.time}" #=> Time object        
    puts "Status message => #{status.message}" #=> "Created at ..."
    puts "Status num => #{status.num}" #=> 5
    puts "Status total => #{status.total}" # => 100
    puts "Status options => #{status.options}" # => 100
    # puts "Status status_ids => #{Resque::Plugins::Status::Hash.status_ids}"
    
    puts "killable? #{status.killable?}"
  end 
   
end

begin
  puts 'Enqueue Jobs'

  threads = [].tap do |threads|
    1.times do
      threads << Thread.new { Start.new }
    end
  end
  
  sleep 1
    
  thread = Thread.new do
    puts "Resque.workers.size => #{Resque.workers.size}"
    
    Resque.workers.each do |worker|
      sleep 1
      
      puts "worker_id => #{worker.to_s}"
      puts "worker.pid => #{worker.pid}"
      puts "worker.worker_pids => #{worker.worker_pids}"

      worker_pid = worker.to_s.split(':')[1].to_i
      
      puts "worker_id => #{worker_pid}"
      puts "worker.processed => #{worker.processed}"
      puts "worker.working? => #{worker.working?}"
      puts "worker.job => #{worker.processing}"
      
      _worker = Resque::Worker.find worker.to_s

      puts "_worker.working? => #{_worker.working?}"
      puts "_worker.worker_id => #{_worker.to_s}"
      puts "_worker.pid => #{_worker.pid}"
      puts "_worker.worker_pids => #{_worker.worker_pids}"

      sleep 1
      puts "Process.kill 'TERM', #{worker_pid}"
      Process.kill 'TERM', worker_pid      
    end
  end # Thread.new
  
  threads << thread
  
  threads.each(&:join)
  
end
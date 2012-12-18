#!/usr/bin/env ruby
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'

require File.expand_path('../myworker.rb', __FILE__)
# require File.expand_path('../string.rb', __FILE__)
# 
# Dir[ File.expand_path('../*.rb', __FILE__) ].each { |f| require f }

begin
  puts 'Enqueue Job'
  
  prng = Random.new

  # 5.times
  job_id = MyWorker.create person: 'Judas Iscariote', length: prng.rand(5..20) 
  puts "job_id => #{job_id}"
  
  # check the status until its complete
  while status = Resque::Plugins::Status::Hash.get(job_id) and !status.completed? && !status.failed?
    
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
    puts "Status status_ids => #{Resque::Plugins::Status::Hash.status_ids}"
    
    puts "killable? #{status.killable?}"

    # Resque.working

# Resque::Worker.all
# Resque::Worker.working

    puts "Resque.workers.size => #{Resque.workers.size}"
    
    Resque.workers.each do |worker|
      
      sleep 1
      
      puts "worker_id => #{worker.to_s}"
      puts "worker.pid => #{worker.pid}"
      puts "worker.worker_pids => #{worker.worker_pids}"
      
      worker_id = worker.to_s.split(':')[1].to_i
      puts "worker_id => #{worker_id}"
      
      # puts "worker_id => #{worker_id}"
      # 
      # puts "worker.processed => #{worker.processed}"
      # puts "worker.working? => #{worker.working?}"
      # puts "worker.job => #{worker.processing}"
      
      _worker = Resque::Worker.find worker.to_s

      puts "_worker.working? => #{_worker.working?}"
      
      puts "_worker.worker_id => #{_worker.to_s}"
      puts "_worker.pid => #{_worker.pid}"
      puts "_worker.worker_pids => #{_worker.worker_pids}"
      
      sleep 1
      
      puts "Process.kill 'TERM', #{worker.pid}"
      Process.kill 'TERM', worker.pid
      
      # Process.kill 'KILL', worker_id
      # Process.kill 'TERM', worker_id
      
      puts '_worker.shutdown!'
      _worker.shutdown!

    end
    
    sleep 1
    exit 0 
    
    if (status.num || 0) > 5
      if status.killable?
        puts "I'll kill you gna gna gna"
        Resque::Plugins::Status::Hash.kill(job_id)  
        exit 0
      end
    end
    
    sleep 1
  end
  
  # 5.times do
  #   status = Resque::Plugins::Status::Hash.get(job_id)
  # end
  # 
  # puts '+ -------------------------------------------------- +'
  # puts "Send SigTerm to #{job_id}"
  # puts '+ -------------------------------------------------- +'
  # 
  # status = Resque::Plugins::Status::Hash.get(job_id)
  # puts "killable? #{status.killable?}"
  # 
  # Resque::Plugins::Status::Hash.kill(job_id) 
  #  
  # sleep 1

  # 
  # if File.exists? 'resque.pid'
  #   puts 'Send SigTerm'
  #   system "kill -15 `cat resque.pid`"
  # else
  #   puts 'please start worker first'
  # end
end
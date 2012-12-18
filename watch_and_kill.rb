#!/usr/bin/env ruby

require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'resque'

begin
  Thread.new do

    while true do
      puts "Resque.workers.size => #{Resque.workers.size}"
    
      Resque.workers.each do |worker|
        sleep 1
      
        # puts "worker_id => #{worker.to_s}"
        # puts "worker.pid => #{worker.pid}"
        # puts "worker.worker_pids => #{worker.worker_pids}"

        worker_pid = worker.to_s.split(':')[1].to_i
      
        puts "worker_id => #{worker_pid}"
        puts "worker.processed => #{worker.processed}"
        puts "worker.working? => #{worker.working?}"
        # puts "worker.job => #{worker.processing}"
      
        # _worker = Resque::Worker.find worker.to_s
        # 
        # puts "_worker.working? => #{_worker.working?}"
        # puts "_worker.worker_id => #{_worker.to_s}"
        # puts "_worker.pid => #{_worker.pid}"
        # puts "_worker.worker_pids => #{_worker.worker_pids}"

        puts "\nProcess.kill 'TERM', #{worker_pid}"
        sleep 1
        Process.kill 'TERM', worker_pid      
      end
      
    end
  end.join
end
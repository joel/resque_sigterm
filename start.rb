#!/usr/bin/env ruby
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'resque'
require File.expand_path('../myworker.rb', __FILE__)

class Start
  
  def initialize
    prng = Random.new
    job_id = MyWorker.create person: 'Judas Iscariote', length: prng.rand(5..8) 
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
  end.each &:join
  
end
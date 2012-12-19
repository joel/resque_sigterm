require 'rubygems'
File.expand_path('Gemfile', __FILE__)
require 'bundler/setup'

class SafeWorker
  
  autoload :Resque, './safe_mode'
  
  include Resque::Plugins::Safer
  
  @queue = :safe_worker
  
  def self.perform *args
    safe_perform *args do
      puts 'Start working'
      5.times { print '.'; sleep 1 }
    end
  end
end
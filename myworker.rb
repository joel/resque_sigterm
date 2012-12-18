require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
require 'uri'
require 'resque/errors'

class MyWorker
  @queue = :worker

  class << self
    
    def perform *args
      begin
        puts 'RESURRECTION! Thanks Dad' if have_already_received_sigterm? *args
        puts 'Yeah i\'m alive!!!'
        puts "#{args.first} you're my friend!"
        10.times { print '.'; sleep 1 }
        
      rescue Resque::TermException
        puts 'O_o someone want to kill me :(...'
        2.times { print '.'; sleep 1 }
        
        count = mark_as_term *args
        puts "You've #{count} frags!"
        
        if count > 3
          clean! *args
          puts 'Omar m\'a tuer...'
        else
          puts 'I\'m Jesus of Nazareth i can\'t died!'
          Resque.enqueue self, *args
        end
      end
    end
    
    protected 
    
    def threshold?
      # 
    end
    
    def have_already_received_sigterm? *args
      Resque.redis.exists cache_key(*args)
    end
    
    def clean! *args
      Resque.redis.del cache_key(*args)
    end
    
    def mark_as_term *args
      Resque.redis.incr cache_key(*args)
    end
    
    private
    
    def cache_key *args
      @cache_key = begin
        _key = "#{self.class.name.underscore}#{args.map(&:underscore).join('_')}"
        puts _key
        _key
      end
    end
    
  end
end

begin
  uri = URI.parse 'redis://localhost:6379'
  _redis = Redis.new host: uri.host, port: uri.port
  Resque.redis = Redis::Namespace.new :resque, redis: _redis
end
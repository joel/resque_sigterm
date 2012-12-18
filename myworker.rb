require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
require 'uri'
require 'resque/errors'
require 'resque/status'

class MyWorker
  include Resque::Plugins::Status
  
  @queue = :worker
  
  THRESHOLD = 4
  
  def perform
    
    begin
      
      puts "Time to live => #{options['length']} secondes"
      
      puts "RESURRECTION! Thanks Dad (You're died #{nb_of_restart(options)} times)" if nb_of_restart(options) > 0
      
      puts 'Yeah i\'m alive!!!'
      name_of_person = options['person'] || 'John Doe' 
      puts "#{name_of_person} you're my friend!"
      
      
      total = (options['length'] || 8).to_i
      num = 0
      while num < total
        at(num, total, "At #{num} of #{total}")
        print '.'
        sleep(1)
        num += 1
      end
         
      # 8.times { print '.'; sleep 1 }
      puts 'bye bye...'
      
    rescue Resque::TermException
      
      puts 'O_o someone want to kill me :(...'
      2.times { print '.'; sleep 1 }
        
      if can_restart? options
        puts "You've #{nb_of_restart(options)} frags!"
        puts 'I\'m Jesus of Nazareth i can\'t died!'
        
        restart! options
      else
        clean! options
        puts 'Omar m\'a tuer...'
      end
    end
    
  end # perform
    
  protected 
  
  def nb_of_restart options
    Resque.redis.get(cache_key(options)).to_i || 0
  end

  def restart! options
    MyWorker.create options
  end
  
  def clean! options
    Resque.redis.del cache_key(options)
  end
    
  def can_restart? options
    Resque.redis.incr(cache_key(options)) <= THRESHOLD
  end
    
  private
    
  def cache_key options
    @cache_key ||= begin
      _key = self.class.name.underscore << '_' << options.collect { |key, value| "#{key.to_s.underscore}_#{value.to_s.underscore}" }.join('_')
      # puts "cache_key => #{_key}"
      _key
    end
  end
  
end

begin
  uri = URI.parse 'redis://localhost:6379'
  _redis = Redis.new host: uri.host, port: uri.port
  Resque.redis = Redis::Namespace.new :resque, redis: _redis
  Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60) # 24hrs in seconds
end
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
require 'uri'

require 'resque/errors'

class MyWorker
  @queue = :worker

  def self.perform
    begin
      puts 'Yeah i\'m alive!!!'
      10.times { print '.'; sleep 1 }
    rescue Resque::TermException
      puts 'O_o someone want to kill me :(...'
      5.times { print '.'; sleep 1 }
    end
  end
end

begin
  uri = URI.parse 'redis://localhost:6379'
  _redis = Redis.new host: uri.host, port: uri.port
  Resque.redis = Redis::Namespace.new :resque, redis: _redis
end
require 'rubygems'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'resque'
require 'uri'

class MyWorker
  @queue = :worker

  def self.perform
    puts "Yeah i'm alive!!!"
  end
end

begin
  uri = URI.parse 'redis://localhost:6379'
  _redis = Redis.new host: uri.host, port: uri.port
  Resque.redis = Redis::Namespace.new :resque, redis: _redis
  puts "Enqueue Job"
  Resque.enqueue MyWorker
end
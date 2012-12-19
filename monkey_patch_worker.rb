require 'resque/helpers'
require 'resque/worker'
require 'resque/version'

module Resque
  class Worker
    def reserve
      raise 'monkey patch is obsolete please update me' if Resque::VERSION != '1.23.0'
      puts "Called on monkey patch !"
      queues.each do |queue|
        log! "Checking fucking queue #{queue}"
        if job = Resque.reserve(queue)
          log! "Found fucking job on queue #{queue}"
          return job
        else
          log! "No found any fucking job on queue #{queue} so i'm kill myself ! bye..."
          sleep 1
          Process.kill 'TERM', self.pid
        end
      end

      nil
    rescue Exception => e
      log "Error reserving fucking job: #{e.inspect}"
      log e.backtrace.join("\n")
      raise e
    end
  end
end
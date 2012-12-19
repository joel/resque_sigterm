require 'resque'
require 'resque/worker'

module Resque
  class Worker
    def reserve
      puts "Call on Subclass => worker.reserve"
      queues.each do |queue|
        log! "Checking fucking #{queue}"
        if job = Resque.reserve(queue)
          log! "Found fucking job on #{queue}"
          return job
        else
          log! "No found any fucking job on #{queue} i'm kill myself ! bye..."
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
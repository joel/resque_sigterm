require 'resque'
require 'resque/worker'

module Resque
  class Worker
    def reserve
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
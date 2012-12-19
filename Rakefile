require 'rake'
require File.expand_path('../monkey_patch_worker.rb', __FILE__)
require 'resque/tasks'

task 'resque:setup' do
  # require File.expand_path('../myworker.rb', __FILE__)
  # require File.expand_path('../string.rb', __FILE__)

  require File.expand_path('../safe_worker.rb', __FILE__)

end



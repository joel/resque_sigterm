require 'rake'
require 'resque/tasks'

task 'resque:setup' do
  require File.expand_path('../myworker.rb', __FILE__)
  require File.expand_path('../string.rb', __FILE__)
  # Dir[ File.expand_path('../*.rb', __FILE__) ].each { |f| require f }
end



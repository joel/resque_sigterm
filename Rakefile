require 'rake'
require 'resque/tasks'

task 'resque:setup' do
  Dir[ File.expand_path('../*.rb', __FILE__) ].each { |f| require f }
end



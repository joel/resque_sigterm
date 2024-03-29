require 'rubygems'
File.expand_path('Gemfile', __FILE__)
require 'bundler/setup'

require 'resque/errors'

module Resque
  module Plugins
    module Safer
      
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        
        def safe_perform *args, &block
          begin
            puts 'You\'re in safe mode'
            yield
          rescue Resque::TermException
            puts 'SIGTERM received'
            2.times { print '.'; sleep 1 }
            puts 're-enqueue'
            Resque.enqueue self, *args
          end
        end
        
      end
    end
  end
end

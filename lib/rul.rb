require 'active_support'
require 'uuid'
require 'rul/rul'

module RUL
  class Railtie < ::Rails::Railtie
    ActiveSupport::BufferedLogger.send(:include, ::RUL::Logging)
  end
end

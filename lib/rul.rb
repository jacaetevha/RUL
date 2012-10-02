require 'active_support'
require 'action_controller'
require 'uuid'
require 'rul/rul'

module RUL
  class Railtie < ::Rails::Railtie
    initializer "RUL" do
      ActionController::Base.send(:include, ::RUL::UUIDInjector)
      ActiveSupport::BufferedLogger.send(:include, ::RUL::Logging)
    end
  end
end

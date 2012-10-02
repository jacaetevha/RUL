require 'active_support/concern'

module RUL

  module Logging
    extend ActiveSupport::Concern

    included do
      alias_method_chain :add, :uuid_info
    end

    module ClassMethods
      @@uuid = UUID.new
  
      def uuid_generator
        @@uuid
      end
    end

    module InstanceMethods
      def add_with_uuid_info severity, message=nil, progname=nil, &block
        uuid = (Thread.current[uuid_key] ||= self.class.uuid_generator.generate)
        # add_without_uuid_info severity, "#{uuid} - #{message}", progname, &block
        add_without_uuid_info severity, "#{Thread.current['session_id']} - #{object_id} - #{message}", progname, &block
      end

      def uuid_key
        @_uuid_id_key ||= :"RUL-#{self.object_id}-uuid"
      end
    end
  end

  module UUIDInjector
    extend ActiveSupport::Concern

    included do
      append_before_filter :set_uuid
    end

    module InstanceMethods
      def set_uuid
        key = if session
          Thread.current[:session_id] ||= session['session_id']
          Thread.current[session['session_id']] ||= logger.class.uuid_generator.generate
        else
          Thread.current[logger.uuid_key] ||= logger.class.uuid_generator.generate
        end
      end
    end
  end
end

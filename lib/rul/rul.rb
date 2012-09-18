module RUL
  module Logging
    @@uuid = UUID.new

    def self.included(base)
      base.class_eval do
        alias_method_chain :add, :uuid_info
      end
    end

    def add_with_uuid_info severity, message=nil, progname=nil, &block
      uuid = (Thread.current[:uuid] ||= @@uuid.generate)
      unless message.include?(uuid)
        message = "#{uuid} - #{message}"
      end
      add_without_uuid_info severity, message, progname, &block
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'ostruct'

describe "RUL" do
  def stub_uuid_generator_with generator
    ActiveSupport::BufferedLogger.stubs(:uuid_generator).returns(generator)
  end

  before :all do
    RUL::Railtie.initializers.each(&:run)
  end

  it "should have a railtie" do
    RUL::Railtie.should_not be_nil
  end

  it "should extend ActionController::Base with RUL::UUIDInjector" do
    ActionController::Base.public_instance_methods.should include(:set_uuid)

    # subclasses should have it too
    controller = Class.new(ActionController::Base)
    controller.public_instance_methods.should include(:set_uuid)
  end

  it "should include RUL::Logging into ActiveSupport::BufferedLogger" do
    ActiveSupport::BufferedLogger.public_instance_methods.should include(:add_with_uuid_info)
    ActiveSupport::BufferedLogger.public_instance_methods.should include(:uuid_key)
  end

  it "should log a message with a UUID" do
    uuid = 'uuid-generator-stub'
    stub_uuid_generator_with OpenStruct.new(:generate => uuid)
    string_io = StringIO.new
    Rails.logger = ActiveSupport::BufferedLogger.new(string_io)
    Rails.logger.error 'foo'
    string_io.rewind
    messages = string_io.read
    messages.chomp.should == "#{uuid} - foo"
  end

  it "should log a message with a UUID within a controller context" do
    uuid = 'uuid-generator-stub'
    stub_uuid_generator_with OpenStruct.new(:generate => uuid)
    string_io = StringIO.new
    ActionController::Base.logger = ActiveSupport::BufferedLogger.new(string_io)
    controller = Class.new(ActionController::Base).new
    controller.instance_eval do
      logger.error 'foo'
    end
    string_io.rewind
    messages = string_io.read
    messages.chomp.should == "#{uuid} - foo"
  end
end
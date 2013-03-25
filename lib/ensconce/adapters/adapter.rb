module Ensconce
  
  # Parent class for adapters. 
  # 
  # Specific adapters should inherit from this class
  class Adapter
    attr_reader :settings, :params
    
    def initialize(args = {})
      @settings = args[:settings]
      @params = args[:params]
    end
    
    def self.config(options = {})
      @options = options
      return self
    end
    
    # The object passed to for should have methods that return the settings
    # for each instance connection. For example, a user object with an id used
    # to retrieve data for that user.
    def self.for(settings_object, params = {})
      new(:settings => settings_object, :params => params)
    end

    def self.options
      @options || {}
    end

    def self.options=(data)
      @options = data
    end
    
    def options
      self.class.options
    end
    
    def get(*args)
      raise_define_method_error('get')
    end
    
    def push(*args)
      raise_define_method_error('push')
    end
    
    
    private
    def raise_define_method_error(name)
      raise "Adapter instance method '#{name}' needs to be defined"
    end
  end
end

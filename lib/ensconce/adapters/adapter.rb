module Ensconce
  
  # Parent class for adapters. 
  # 
  # Specific adapters should inherit from this class
  class Adapter
    
    def self.config(options = {})
      @options = options
      return self
    end

    def self.options
      @options || {}
    end

    def self.options=(data)
      @options = data
    end
    
    def self.get(*args)
      raise_define_method_error('get')
    end
    
    def self.push(*args)
      raise_define_method_error('push')
    end
    
    private
    def self.raise_define_method_error(name)
      raise "Class method '#{name}' needs to be defined"
    end
  end
end

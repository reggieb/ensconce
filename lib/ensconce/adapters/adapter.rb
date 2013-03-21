module Ensconce
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
    
    def self.get
      raise_define_method_error
    end
    
    def self.push
      raise_define_method_error
    end
    
    private
    def self.raise_define_method_error
      raise "Class get method needs to be defined"
    end
  end
end

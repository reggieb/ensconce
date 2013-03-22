
module Ensconce
  class KeyMap
      
    def self.for(key)
      mappings[key]
    end
    
    def self.mappings
      @mappings ||= default_mappings
    end
    
    def self.map_generator(args)
      MapGenerator.new(args).map
    end
    
    def self.default_mapping
      raise "default_mapping must be defined"
    end
    
  end
end

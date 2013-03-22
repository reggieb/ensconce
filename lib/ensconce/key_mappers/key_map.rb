
module Ensconce
  class KeyMap
      
    def self.for(key)
      key_map = new 
      key_map[key]
    end
    
    def mappings
      @mappings ||= default_mappings
    end
    
    def [](key)
      mappings[key]
    end
    
    def map_generator(args)
      MapGenerator.new(args).map
    end
    
    def default_mapping
      raise "default_mapping must be defined"
    end
    
  end
end

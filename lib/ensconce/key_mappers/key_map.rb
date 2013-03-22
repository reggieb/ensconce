module Ensconce
  
  # Parent class for key maps. 
  # 
  # Specific key maps should inherit from this class
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
      RekeyMapGenerator.new(
        :keys => (args[:original] || args[:keys]),
        :values => (args[:replacement] || args[:values]),
        :keys_mod => (args[:original_mod] || args[:keys_mod]),
        :values_mod => (args[:replacement_mod] || args[:values_mod])
      ).map
    end
    
    def default_mapping
      raise "default_mapping must be defined"
    end
    
  end
end

module Ensconce
  
  # Used to convert pairs of arrays into a hash
  # 
  #     map_generator = MapGenerator.new :keys => ['a', 'b'], :values => ['1', '2']
  #     map_generator.map   --> {'a' => '1', 'b' => '2'}
  #     
  # Also allows modification of keys or values
  # 
  #    map_generator.keys_mod = lambda {|key| key.upcase}
  #    map_generator.map   --> {'A' => '1', 'B' => '2'}
  #    
  #    map_generator.values_mod = lambda {|value| (value.to_i * 4).to_s}
  #    map_generator.map   --> {'A' => '4', 'B' => '8'}
  #    
  # You can use a Proc to define a mod, but I'd recommend not doing so as a
  # return statement in the Proc can cause an unexpected result (see tests).
  #
  
  class MapGenerator
    
    attr_accessor :keys, :values, :keys_mod, :values_mod
    
    def initialize(args = {})
      @keys = args[:keys]
      @values = args[:values]
      @keys_mod = args[:keys_mod]
      @values_mod = args[:values_mod]
    end
    
    def valid?
      check_required_attributes_present
      check_mods_are_valid
    end
    
    def map
      valid?
      map = [processed_keys, processed_values].transpose
      Hash[map]
    end
    
    def check_mods_are_valid
      mod_attributes.each do |mod|
        mod = send mod
        next unless mod
        raise ":#{mod} must be a Proc or lambda" unless mod.kind_of? Proc
      end
    end
    
    def check_required_attributes_present
      required_attibutes.each do |attribute|
        raise ":#{attribute} is a required attribute but was not found" unless send(attribute)
      end
    end
    
    def required_attibutes
      [:keys, :values]
    end
    
    def mod_attributes
      [:keys_mod, :values_mod]
    end
    
    def processed_keys
      keys_mod ? keys.collect(&keys_mod) : keys
    end
    
    def processed_values
      values_mod ? values.collect(&values_mod) : values
    end
  end
end

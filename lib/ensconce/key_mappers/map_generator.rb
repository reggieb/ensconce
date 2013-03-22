module Ensconce
  class MapGenerator
    
    attr_accessor :original, :replacement, :original_mod, :replacement_mod
    
    def initialize(args = {})
      @original = args[:original]
      @replacement = args[:replacement]
      @original_mod = args[:original_mod]
      @replacement_mod = args[:replacement_mod]
    end
    
    def valid?
      check_required_attributes_present
      check_mods_are_valid
    end
    
    def map
      valid?
      map = [processed_original, processed_replacement].transpose
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
      [:original, :replacement]
    end
    
    def mod_attributes
      [:original_mod, :replacement_mod]
    end
    
    def processed_original
      original_mod ? original.collect(&original_mod) : original
    end
    
    def processed_replacement
      replacement_mod ? replacement.collect(&replacement_mod) : replacement
    end
  end
end


module Ensconce
  module Mangle
    
    # Hash#merge will replace the value of a key with its replacement's value.
    # If the value is itself a hash, the original is replaced.
    # With deep_merge, if the value is a hash the original value is merged with
    # the replacements.
    #     original    = {one: {two: 2}, three: 3}
    #     replacement = {one: {four: 4}}
    #     original.merge(replacement)              --> {one: {four: 4}, three: 3}
    #     Mangle.deep_merge(original, replacement) --> {one: {two: 2, four: 4}, three: 3}
    def self.deep_merge(original, replacement)
      if original.kind_of? Hash
        original.merge(replacement){|key, oldval, newval| deep_merge(oldval, newval)}
      else
        replacement
      end
    end
    
    # Changes the keys of a hash based on a hash. The map is a hash where the
    # values are the old keys, and the values are the replacement keys
    #     original = {one: {two: 2}, three: 3}
    #     hash      = {one: :four, three: :five}
    #     Mangle.rekey(original, hash)  -->   {four: {two: 2}, five: 3}
    def self.rekey(hash, change_map)
      change_map.each{|old, new| hash[new] = hash.delete(old)}
      return hash
    end
  end
end

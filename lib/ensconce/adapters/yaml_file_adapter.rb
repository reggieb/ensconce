module Ensconce
  class YamlFileAdapter < Adapter

    def self.get(key = nil)
      raise "No file defined" unless options[:file]
      data = YAML.load_file options[:file]
      key ? data[key] : data
    end

    def self.push(key, data)
      result = deep_merge get, {key => data}
      File.open(options[:file], 'w+') {|f| f.write(result.to_yaml) }
    end

    private
    def self.deep_merge(original, replacement)
      if original.kind_of? Hash
        original.merge(replacement){|key, oldval, newval| deep_merge(oldval, newval)}
      else
        replacement
      end
    end


  end
end
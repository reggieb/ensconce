
class YamlFile
  
  def self.config(options = {})
    @options = options
  end
  
  def self.get_data
    raise "No file defines" unless options[:file]
    YAML.load_file options[:file]
  end
  
  def self.push_data(data)
    result = deep_merge get_data, data
    File.open(options[:file], 'w+') {|f| f.write(result.to_yaml) }
  end
  
  def self.deep_merge(original, replacement)
    if original.kind_of? Hash
      original.merge(replacement){|key, oldval, newval| deep_merge(oldval, newval)}
    else
      replacement
    end
  end
  
  def self.options
    @options || {}
  end
  
  def self.options=(data)
    @options = data
  end
end

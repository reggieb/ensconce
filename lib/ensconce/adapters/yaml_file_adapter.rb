module Ensconce
  class YamlFileAdapter < Adapter
    
    def self.all
      YAML.load_file options[:file]
    end

    def get
      raise "No file defined" unless options[:file]
      data = YAML.load_file options[:file]
      data[settings.id]
    end

    def push(data)
      result = Mangle.deep_merge self.class.all, {settings.id => data}
      File.open(options[:file], 'w+') {|f| f.write(result.to_yaml) }
    end
    

  end
end
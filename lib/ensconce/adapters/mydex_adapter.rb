require 'faraday'
require 'json'

module Ensconce

  class MydexAdapter < Adapter
    
    def self.get(key= 'field_ds_personal_details')
      @key = key
      response = connection.get(
        path,
        params.merge({ dataset: @key })
      )
      @data = JSON.parse response.body
      @data = @data[@key]['instance_0']
      change_data_keys_to_data_store_names
      extact_values
    end
    
    def self.push(key, data)
      @key = key
      @data = data
      change_data_keys_to_mydex_names
      response = connection.put do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.body = {@key => [@data]}.to_json
        req.params = params
      end
      response.body
    end
    
    def self.connection
      Faraday.new(:url => options[:url]) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
#        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end      
    end
    
    def self.params
      {
        key: options[:key],
        api_key: options[:api_key],
        con_id: options[:con_id],
        source_type: 'connection' 
      }
    end

    def self.path
      "api/pds/pds/#{options[:id]}.json"
    end
    
    def self.change_data_keys_to_data_store_names
      @data = Mangle.rekey(@data, key_map(@key))
    end
    
    def self.change_data_keys_to_mydex_names
      @data = Mangle.rekey(@data, key_map(@key).invert)
    end
    
    def self.extact_values
      HashBuilder.new(
        keys: @data.keys, 
        values: @data.values,
        values_mod: lambda {|value| value['value']}
      ).hash
    end
    
    def self.key_map(key)
      MydexKeyMap.for(key)
    end
  end
  
end

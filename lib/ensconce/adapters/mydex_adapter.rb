require 'faraday'
require 'json'

module Ensconce

  class MydexAdapter < Adapter
    
    def get
      @data_set = params[:data_set]
      response = connection.get(
        path,
        params.merge({ dataset: @data_set })
      )
      @data = JSON.parse response.body
      @data = @data[@data_set]['instance_0']
      change_data_keys_to_data_store_names
      extact_values
    end
    
    def push(data)
      @data_set = params[:data_set]
      @data = data
      change_data_keys_to_mydex_names
      response = connection.put do |req|
        req.url path
        req.headers['Content-Type'] = 'application/json'
        req.body = {@data_set => [@data]}.to_json
        req.params = params
      end
      response.body
    end
    
    def connection
      Faraday.new(:url => options[:url]) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
#        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end      
    end
    
    def params
      super.merge(
        key: settings.key,
        api_key: options[:api_key],
        con_id: settings.con_id,
        source_type: 'connection' 
      )
    end

    def path
      "api/pds/pds/#{settings.id}.json"
    end
    
    def change_data_keys_to_data_store_names
      @data = Mangle.rekey(@data, key_map(@data_set))
    end
    
    def change_data_keys_to_mydex_names
      @data = Mangle.rekey(@data, key_map(@data_set).invert)
    end
    
    def extact_values
      HashBuilder.new(
        keys: @data.keys, 
        values: @data.values,
        values_mod: lambda {|value| value['value']}
      ).hash
    end
    
    def key_map(key)
      MydexKeyMap.for(key)
    end
  end
  
end

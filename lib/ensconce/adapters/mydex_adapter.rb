require 'faraday'
require 'json'

module Ensconce

  class MydexAdapter < Adapter
    def initialize

    end
    
    def self.get(key= 'field_ds_personal_details')
      response = connection.get(
        path,
        params.merge({ dataset: key })
      )
      data = JSON.parse response.body
      data = data[key]['instance_0']
      Mangle.rekey(data, key_map(key))
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
    
    def self.key_map(key)
      MydexKeyMap.for(key)
    end
  end
  
end

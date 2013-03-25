require_relative '../../test_helper'

module Ensconce
  class MydexAdapterTest < Test::Unit::TestCase
    def setup
      
      MydexAdapter.config(
        url: settings['mydex']['url'],
        api_key: settings['mydex']['api_key']
      )
    end
    
    def test_adapter_for
      user = TestUser.new(
        :key => settings['mydex']['key'], 
        :con_id => settings['mydex']['con_id'],
        :id => settings['mydex']['id']
      )
      @adapter = MydexAdapter.for(user, :data_set => 'field_ds_personal_details')
      assert_equal(settings['mydex']['key'], @adapter.settings.key)
    end


    
    def test_get
      test_adapter_for
      VCR.use_cassette('datastore_test_get') do
        data = @adapter.get
        assert_equal(MydexKeyMap.field_ds_personal_details_map[:replacement], data.keys)
        assert(data.values.collect{|v| v unless v.empty?}.compact.length > 0, "Values should not all be empty")
      end
    end

    def test_push
      values = %w{Harry Mary Trevor}
      key = 'first_name'
      test_adapter_for
      values.each do |value|
        VCR.use_cassette("datastore_push_#{value}") do
          @adapter.push({key => value})
        end
        VCR.use_cassette("datastore_get_#{value}") do
          result = @adapter.get
          assert_equal(value, result[key])
        end      
      end
    end
  end
end

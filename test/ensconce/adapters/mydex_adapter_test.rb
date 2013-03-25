require_relative '../../test_helper'

module Ensconce
  class MydexAdapterTest < Test::Unit::TestCase
    def setup
      mydex_settings = settings['mydex']
      mydex_settings = HashBuilder.new(
        :keys => mydex_settings.keys, 
        :values => mydex_settings.values,
        :keys_mod => lambda {|key| key.to_sym}
      ).hash
      MydexAdapter.config(mydex_settings)
    end

    def test_get
      VCR.use_cassette('datastore_test_get') do
        data = MydexAdapter.get
        assert_equal(MydexKeyMap.field_ds_personal_details_map[:replacement], data.keys)
        assert(data.values.collect{|v| v unless v.empty?}.compact.length > 0, "Values should not all be empty")
      end
    end
    
    def test_get_for_specific_user
      VCR.use_cassette('datastore_test_get_specfic_user') do
        data = MydexAdapter.get 'field_ds_personal_details'
        assert_equal(MydexKeyMap.field_ds_personal_details_map[:replacement], data.keys)
        assert(data.values.collect{|v| v unless v.empty?}.compact.length > 0, "Values should not all be empty")
      end
    end

    def test_push
      values = %w{Harry Mary Trevor}
      key = 'first_name'
      
      values.each do |value|
        VCR.use_cassette("datastore_push_#{value}") do
          MydexAdapter.push('field_ds_personal_details', {key => value})
        end
        VCR.use_cassette("datastore_get_#{value}") do
          result = MydexAdapter.get 'field_ds_personal_details'
          assert_equal(value, result[key])
        end      
      end
    end
  end
end

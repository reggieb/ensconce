require_relative '../../test_helper'

module Ensconce
  class MydexAdapterTest < Test::Unit::TestCase
    def setup
      MydexAdapter.config(
        url: 'https://sbx-api.mydex.org/',
        key: 'LlPwdnq38tMtCPP7u60HjTYy35MxAVkf',
        api_key: 'rN31O75AWviNYezE2vWsMDP6kS88Zc5P',
        con_id: '93-1545', 
        id: 93
      )
    end

    def test_get
      data = MydexAdapter.get
      assert_equal(MydexKeyMap.field_ds_personal_details_map[:replacement], data.keys)
      assert(data.values.collect{|v| v unless v.empty?}.compact.length > 0, "Values should not all be empty")
    end
    
    def test_get_for_specific_user
      data = MydexAdapter.get 'field_ds_personal_details'
      assert_equal(MydexKeyMap.field_ds_personal_details_map[:replacement], data.keys)
      assert(data.values.collect{|v| v unless v.empty?}.compact.length > 0, "Values should not all be empty")
    end

    def test_push
      values = %w{Harry Mary Trevor}
      key = 'first_name'
      
      values.each do |value|
        MydexAdapter.push('field_ds_personal_details', {key => value})
        result = MydexAdapter.get 'field_ds_personal_details'
        assert_equal(value, result[key])
      end
    end
  end
end

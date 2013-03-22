require_relative '../../test_helper'

module Ensconce
  class MydexAdapterTest < Test::Unit::TestCase
    def setup
      @users = fixture['users']
      MydexAdapter.config(
        url: 'https://sbx-api.mydex.org/',
        key: 'LlPwdnq38tMtCPP7u60HjTYy35MxAVkf',
        api_key: 'rN31O75AWviNYezE2vWsMDP6kS88Zc5P',
        con_id: '93-1545', 
        id: 93
      )
    end

    def test_get
      assert_equal(@users, MydexAdapter.get)
    end
    
#    def test_get_for_specific_user
#      assert_equal(@users['user_1'], MydexAdapter.get('user_1'))
#    end
#
#    def test_push
#      update = {"first_name" => 'Harry'}
#      MydexAdapter.push('user_1', update)
#      @users['user_1'].merge!(update)
#      assert_equal(@users, current_data_for('users'))
#    end
  end
end

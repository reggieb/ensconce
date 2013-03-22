require_relative '../test_helper'

module Ensconce
  class DataStoreTest < Test::Unit::TestCase
    def setup
      DataStore.adapter = YamlFileAdapter.config(:file => data_path('users'))
      @users = fixture['users']
      @data_store = DataStore.open 'user_1'
    end
    
    def test_open
      assert_equal(@users['user_1'], @data_store)
    end
    
    def test_save
      name = 'Gillian'
      @data_store['first_name'] = name
      @data_store.save
      @users['user_1'].merge!({'first_name' => name})
      assert_equal(@users, current_data_for('users'))
    end
    
    def test_new
      @key = 'user_99'
      @user = {
        @key => {
          'first_name' => 'Ice',
          'last_name' => 'Cream',
          'gender' => 'female'
        }
      }
      @data_store = DataStore.new(@key, @user[@key])
      assert_equal(@user[@key], @data_store)
    end
    
    def test_create
      test_new
      @data_store.save
      @users.merge! @user
      assert_equal(@users, current_data_for('users'))
    end
    
    def test_with_mydex_adapter
      DataStore.adapter = MydexAdapter.config(
        url: 'https://sbx-api.mydex.org/',
        key: 'LlPwdnq38tMtCPP7u60HjTYy35MxAVkf',
        api_key: 'rN31O75AWviNYezE2vWsMDP6kS88Zc5P',
        con_id: '93-1545', 
        id: 93
      )
      @data_store = DataStore.open('field_ds_personal_details')
      name = 'Gillian'
      @data_store['first_name'] = name
      @data_store.save
      result = DataStore.open('field_ds_personal_details')
      assert_equal(name, result['first_name'])
    end
  end
end

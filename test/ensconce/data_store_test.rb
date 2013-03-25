require_relative '../test_helper'

module Ensconce
  class DataStoreTest < Test::Unit::TestCase
    def setup
      DataStore.adapter = YamlFileAdapter.config(:file => data_path('users'))
      @users = fixture['users']
      user = TestUser.new(id: 'user_1')
      @data_store = DataStore.open user
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
      user = TestUser.new(id: 'user_99')
      @user = {
        user.id => {
          'first_name' => 'Ice',
          'last_name' => 'Cream',
          'gender' => 'female'
        }
      }
      @data_store = DataStore.new(user, :data => @user[user.id])
      assert_equal(@user[user.id], @data_store)
    end
    
    def test_create
      test_new
      @data_store.save
      @users.merge! @user
      assert_equal(@users, current_data_for('users'))
    end
    
    def test_with_mydex_adapter
      DataStore.adapter = MydexAdapter.config(        
        url: settings['mydex']['url'],
        api_key: settings['mydex']['api_key']
      )
      @user = TestUser.new(
        :key => settings['mydex']['key'], 
        :con_id => settings['mydex']['con_id'],
        :id => settings['mydex']['id']
      )
      VCR.use_cassette('datastore_before_mydex_adapter_test') do
        @data_store = DataStore.open(
          @user, 
          :data_set => 'field_ds_personal_details')
        @name = 'Gillian'
        @data_store['first_name'] = @name
        @data_store.save
      end  
      VCR.use_cassette('datastore_after_mydex_adapter_test') do
        result = DataStore.open(
          @user, 
          :data_set => 'field_ds_personal_details'
        )
        assert_equal(@name, result['first_name'])
      end
      
    end
  end
end

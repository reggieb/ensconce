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
  end
end

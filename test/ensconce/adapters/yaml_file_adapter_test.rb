require_relative '../../test_helper'

module Ensconce
  class YamlFileAdapterTest < Test::Unit::TestCase
    
    def setup
      @users = fixture['users']
      YamlFileAdapter.config(
        :file => data_path('users')
      )
    end

    def test_setup
      assert_equal(current_data_for('users'), @users)
    end

    def test_get
      assert_equal(@users, YamlFileAdapter.get)
    end
    
    def test_get_for_specific_user
      assert_equal(@users['user_1'], YamlFileAdapter.get('user_1'))
    end

    def test_push
      update = {"first_name" => 'Harry'}
      YamlFileAdapter.push('user_1', update)
      @users['user_1'].merge!(update)
      assert_equal(@users, current_data_for('users'))
    end

  end
end

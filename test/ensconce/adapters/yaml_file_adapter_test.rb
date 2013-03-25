require_relative '../../test_helper'

module Ensconce
  class YamlFileAdapterTest < Test::Unit::TestCase
    
    def setup
      @users = fixture['users']
      YamlFileAdapter.config(
        :file => data_path('users')
      )
      @user = TestUser.new(:id => 'user_1')
      @adapter = YamlFileAdapter.for(@user)
    end

    def test_setup
      assert_equal(current_data_for('users'), @users)
    end

    def test_get
      assert_equal(@users[@user.id], @adapter.get)
    end

    def test_push
      update = {"first_name" => 'Harry'}
      @adapter.push(update)
      @users[@user.id].merge!(update)
      assert_equal(@users, current_data_for('users'))
    end

  end
end

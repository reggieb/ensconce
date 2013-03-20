$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require_relative '../../lib/ensconce'
require 'yaml'
require 'fileutils'

module Ensconce
  class YamlFileTest < Test::Unit::TestCase
    def setup
      load_user_fixture
      @user_data = YAML.load_file(@user_file_path)
      YamlFile.config(
        :file => @user_file_path
      )
    end

    def test_setup
      template = YAML.load_file(@user_template_path)
      assert_equal(template, @user_data)
    end

    def test_get_data
      assert_equal(@user_data, YamlFile.get_data)
    end

    def test_push_data
      update = {"user" => {"first_name" => 'Harry'}}
      YamlFile.push_data(update)
      @user_data['user'].merge!(update['user'])
      assert_equal(@user_data, YAML.load_file(@user_file_path))
    end


    private
    def load_user_fixture
      @user_template_path = File.expand_path('../fixtures/user.yml', File.dirname(__FILE__))
      @user_file_path = File.expand_path('../data/user.yml', File.dirname(__FILE__))
      FileUtils.copy @user_template_path, @user_file_path
    end
  end
end

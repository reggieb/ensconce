require 'test/unit'
require_relative '../lib/ensconce'
require 'yaml'
require 'fileutils'

class Test::Unit::TestCase
  private
  def fixture_path(element = nil)
    add_element_to_relative_path element, 'fixtures'
  end
  
  def data_path(element = nil)
    add_element_to_relative_path element, 'data'
  end
  
  def add_element_to_relative_path(element, relative_path)
    path = []
    path << File.expand_path(relative_path, File.dirname(__FILE__))
    path << "#{element}.yml" if element
    path.join('/')
  end
  
  def fixture
    @fixture ||= load_fixtures
  end
  
  def load_fixtures
    output = {}
    fixtures = %w{users}
    fixtures.each do |name|
      template = fixture_path(name)
      destination = data_path(name)
      FileUtils.copy template, destination
      output[name] = YAML.load_file template
    end
    return output
  end
  
  def current_data_for(name)
    YAML.load_file data_path(name)
  end
  
  def settings
    YAML.load_file File.expand_path('../settings.yml', File.dirname(__FILE__))
  end
  
end

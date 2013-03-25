require 'test/unit'
require_relative '../lib/ensconce'
require 'yaml'
require 'fileutils'
require 'vcr'

# VCR records HTTP requests and replays them on future test. Speeds up testing
# and removes dependency on remote app being working and available during tests.
# However, they should be reset as required.
VCR.configure do |c|
  cassette_path = 'fixtures/vcr_cassettes' # Remove files in this folder to reset vcr
  c.cassette_library_dir = File.expand_path(cassette_path, File.dirname(__FILE__))
  c.hook_into :webmock # or :fakeweb
end

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
  
  class TestUser
    attr_accessor :key, :id, :con_id
    
    def initialize(args = {})
      @key = args[:key]
      @id = args[:id]
      @con_id = args[:con_id]
    end
  end
  
end

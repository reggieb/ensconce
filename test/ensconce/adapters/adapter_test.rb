require 'test/unit'
require_relative '../../../lib/ensconce'

module Ensconce
  class AdapterTest < Test::Unit::TestCase
    def test_config
      stuff = {foo: 'bar'}
      Adapter.config(stuff)    
      assert_equal(stuff, Adapter.options)
    end
    
    def test_method_holders
      methods = %w{get push}
      adapter = Adapter.new
      methods.each do |method|
        assert_raise RuntimeError, "Adapter.#{method} should raise an error." do
          adapter.send method
        end
      end  
    end
  end
end

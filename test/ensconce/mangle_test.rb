require_relative '../test_helper'

module Ensconce
  class MangleTest < Test::Unit::TestCase
    
    def setup
      @hash = {foo: {bar: 38, chew: 12}, this: 'that'}
    end
    
    def test_deep_merge
      replacement = {foo: {bar: 21}}
      expected = {foo: {bar: 21, chew: 12}, this: 'that'}
      assert_equal(expected, Mangle.deep_merge(@hash, replacement))
    end
    
    def test_rekey
      map = {
        foo: :changed_foo,
        this: :changed_this
      }
      expected = {changed_foo: {bar: 38, chew: 12}, changed_this: 'that'}
      assert_equal(expected, Mangle.rekey(@hash, map))
    end
  end
end

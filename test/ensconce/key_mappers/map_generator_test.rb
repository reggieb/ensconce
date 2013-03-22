require_relative '../../test_helper'

module Ensconce
  class MapGeneratorTest < Test::Unit::TestCase
    
    def setup
      @words = %w{one two three}
      @numbers = %w{1 2 3}
      @map_generator = RekeyMapGenerator.new(
        :keys => @words,
        :values => @numbers
      )
    end
    
    def test_initiation
      assert_equal @words, @map_generator.keys
      assert_equal @numbers, @map_generator.values
    end
    
    def test_lack_of_keys
      map_generator = RekeyMapGenerator.new(:values => @numbers)
      assert_raise RuntimeError do
        map_generator.map
      end
    end
    
    def test_lack_of_values
      map_generator = RekeyMapGenerator.new(:keys => @numbers)
      assert_raise RuntimeError do
        map_generator.map
      end
    end
    
    def test_map
      expected = {'one' => '1', 'two' => '2', 'three' => '3'}
      assert_equal(expected, @map_generator.map)
    end
    
    def test_keys_mod
      @map_generator.keys_mod = lambda {|element| element.upcase}
      expected = {'ONE' => '1', 'TWO' => '2', 'THREE' => '3'}
      assert_equal(expected, @map_generator.map)
    end
    
    def test_keys_mod_with_invalid_input
      @map_generator.keys_mod = 'x'
      assert_raise RuntimeError do
        @map_generator.map
      end 
    end
    
    def test_values_mod
      @map_generator.values_mod = lambda {|element| (element.to_i * 2).to_s}
      expected = {'one' => '2', 'two' => '4', 'three' => '6'}
      assert_equal(expected, @map_generator.map)
    end
    
    # Test added to show how procs with returns in mods can cause unexpected results
    def test_mod_with_proc
      @map_generator.values_mod = Proc.new {|element| return (element.to_i * 2).to_s}
      map = @map_generator.map
      flunk "Never gets here"
      # because return in Proc stops process and returns value to test_mod_with_proc caller
    end
    
    # Demonstration that it is the return in the Proc that messes up the test.
    # If you alter 'expected' in this test, the test will fail.
    def test_mod_with_proc_and_no_return
      @map_generator.values_mod = Proc.new {|element| (element.to_i * 2).to_s}
      expected = {'one' => '2', 'two' => '4', 'three' => '6'}
      map = @map_generator.map
      assert_equal(expected, map)
    end
    
    # Test with lambda shows a more predictable result
    def test_mod_with_lambda
      @map_generator.values_mod = lambda {|element| return (element.to_i * 2).to_s}
      expected = {'one' => '2', 'two' => '4', 'three' => '6'}
      map = @map_generator.map
      assert_equal(expected, map)
    end
    
    def test_mod_with_lambda_and_no_return
      @map_generator.values_mod = lambda {|element| (element.to_i * 2).to_s}
      expected = {'one' => '2', 'two' => '4', 'three' => '6'}
      map = @map_generator.map
      assert_equal(expected, map)
    end
    
    def test_mods_on_initiation
      map_generator = RekeyMapGenerator.new(
        :keys => @words,
        :values => @numbers,
        :keys_mod => lambda {|element| element.reverse},
        :values_mod => Proc.new {|element| (element.to_i + 2).to_s}
      )
      expected = {'eno' => '3', 'owt' => '4', 'eerht' => '5'}
      assert_equal(expected, map_generator.map)
    end
    
  end
end

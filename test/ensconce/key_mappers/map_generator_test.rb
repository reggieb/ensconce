require_relative '../../test_helper'

module Ensconce
  class MapGeneratorTest < Test::Unit::TestCase
    
    def setup
      @words = %w{one two three}
      @numbers = %w{1 2 3}
      @map_generator = MapGenerator.new(
        :original => @words,
        :replacement => @numbers
      )
    end
    
    def test_initiation
      assert_equal @words, @map_generator.original
      assert_equal @numbers, @map_generator.replacement
    end
    
    def test_lack_of_original
      map_generator = MapGenerator.new(:replacement => @numbers)
      assert_raise RuntimeError do
        map_generator.map
      end
    end
    
    def test_lack_of_replacement
      map_generator = MapGenerator.new(:original => @numbers)
      assert_raise RuntimeError do
        map_generator.map
      end
    end
    
    def test_map
      expected = {'one' => '1', 'two' => '2', 'three' => '3'}
      assert_equal(expected, @map_generator.map)
    end
    
    def test_original_mod
      @map_generator.original_mod = lambda {|element| element.upcase}
      expected = {'ONE' => '1', 'TWO' => '2', 'THREE' => '3'}
      assert_equal(expected, @map_generator.map)
    end
    
    def test_original_mod_with_invalid_input
      @map_generator.original_mod = 'x'
      assert_raise RuntimeError do
        @map_generator.map
      end 
    end
    
    def test_replacement_mod
      @map_generator.replacement_mod = lambda {|element| (element.to_i * 2).to_s}
      expected = {'one' => '2', 'two' => '4', 'three' => '6'}
      assert_equal(expected, @map_generator.map)
    end
    
    def test_mod_with_proc
      @map_generator.replacement_mod = Proc.new {|element| (element.to_i * 2).to_s}
      expected = {'one' => '2', 'two' => '4', 'three' => '6'}
      assert_equal(expected, @map_generator.map)
    end
    
    def test_mods_on_initiation
      map_generator = MapGenerator.new(
        :original => @words,
        :replacement => @numbers,
        :original_mod => lambda {|element| element.reverse},
        :replacement_mod => Proc.new {|element| (element.to_i + 2).to_s}
      )
      expected = {'eno' => '3', 'owt' => '4', 'eerht' => '5'}
      assert_equal(expected, map_generator.map)
    end
    
  end
end

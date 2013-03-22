require_relative '../../test_helper'

module Ensconce
  class MydexKeyMapTest < Test::Unit::TestCase
    def test_for
      expected = {
        "field_personal_fname"=>"first_name", 
        "field_personal_faname"=>"last_name", 
        "field_personal_gender"=>"gender", 
        "field_personal_maname"=>"maiden_name", 
        "field_personal_mname"=>"middle_name", 
        "field_personal_nickname"=>"nick_name", 
        "field_personal_suffix"=>"suffix", 
        "field_personal_title"=>"title"
      }
      map = MydexKeyMap.for('field_ds_personal_details')
      assert_equal(expected, map)
    end
  end
end

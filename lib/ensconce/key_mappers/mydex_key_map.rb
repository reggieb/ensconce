module Ensconce
  class MydexKeyMap < KeyMap
        
    def default_mappings
      {
        'field_ds_personal_details' => field_ds_personal_details
      }
    end
    
    def field_ds_personal_details
      map_generator( self.class.field_ds_personal_details_map )
    end
    
    def self.field_ds_personal_details_map
      {
        :original =>    %w{fname      faname    gender maname      mname       nickname  suffix title},
        :replacement => %w{first_name last_name gender maiden_name middle_name nick_name suffix title},
        :original_mod => lambda {|field| "field_personal_#{field}"}        
      }
    end
      
  end
end

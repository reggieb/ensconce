module Ensconce
  class MydexKeyMap < KeyMap
        
    def default_mappings
      {
        'field_ds_personal_details' => field_ds_personal_details
      }
    end
    
    def field_ds_personal_details
      map_generator(
        :keys =>    %w{fname      faname    gender maname      mname       nickname  suffix title},
        :values => %w{first_name last_name gender maiden_name middle_name nick_name suffix title},
        :keys_mod => lambda {|field| "field_personal_#{field}"}
      )
    end 
      
  end
end

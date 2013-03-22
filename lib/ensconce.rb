# load order specific files
require_relative 'ensconce/adapters/adapter'
require_relative 'ensconce/key_mappers/key_map'

# load everything else
Dir[File.dirname(__FILE__) + "/ensconce/**/*.rb"].each{|file| require file}

module Ensconce
   
end

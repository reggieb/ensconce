# load order specific files
require_relative 'ensconce/adapters/adapter'

# load everything else
Dir[File.dirname(__FILE__) + "/ensconce/**/*.rb"].each{|file| require file}

module Ensconce
   
end

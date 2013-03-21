
class DataStore < Hash
  attr_accessor :name
  
  def initialize(name, hash = {})
    super()
    @name = name
    replace hash
  end
  
  def save
    raise "adapter must be specifed" unless adapter
    adapter.push(name, self)
  end
  
  def adapter
    self.class.adapter
  end
  
  def self.open(name)
    raise "adapter must be specifed" unless adapter
    data = adapter.get(name)
    new name, data
  end
  
  
  def self.adapter
    @adapter
  end
  
  def self.adapter=(klass)
    @adapter = klass
  end
end

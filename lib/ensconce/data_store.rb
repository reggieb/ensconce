
class DataStore < Hash
  attr_accessor :settings, :params
  
  def initialize(settings_object, params = {})
    super()
    data = params.delete(:data)
    @params = params
    @settings = settings_object
    replace data if data
  end
  
  def save
    raise "adapter must be specifed" unless adapter
    adapter.push({}.merge(self))
  end
  
  def adapter
    @adapter ||= self.class.adapter.for(settings, params)
  end
  
  def get
    replace adapter.get.merge(self)
  end
  
  
  def self.open(settings_object, params = {})
    data_store = new settings_object, params
    data_store.get
    return data_store
  end
  
  def self.adapter=(klass)
    @adapter_klass = klass
  end
  
  def self.adapter
    @adapter_klass
  end
  
end

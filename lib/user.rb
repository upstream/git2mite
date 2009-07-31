class User
  attr_accessor :name, :id
  
  def initialize(attributes = {})
    self.name = attributes[:name]
    self.id = attributes[:id]
  end
  
  def self.all(mite_client)
    mite_client.get('/users.json').map do |json|
      User.new :name => json['user']['name'], :id => json['user']['id']
    end
  end
end

require 'rubygems'
gem 'rest-client'
require 'rest_client'

gem 'json'
require 'json'


require 'builder'

class MiteClient
  
  def initialize(url, api_key)
    @url = url
    @api_key = api_key
  end
  
  def time_entries(project_id, user_id, date)
    get("/time_entries.json?project-id=#{project_id}&user-id=#{user_id}&at=#{date.to_s}")
  end
  
  def projects
    get '/projects.json'
  end
  
  def add_message_to_entry(entry, message)
    builder = Builder::XmlMarkup.new
    builder.tag!('time-entry') do |time_entry|
      time_entry.note((entry['note'].size == 0 ? '' : entry['note'] + ', ') + message)
    end
    put "/time_entries/#{entry['id']}.xml", builder.target!
  end
  
  def get(path)
    JSON.parse(RestClient.get(@url + path, {'X-MiteApiKey' => @api_key, 'Content-Type' => 'application/json'}))
  end
  
  private
  
  def put(path, xml)
    RestClient.put(@url + path, xml, {'X-MiteApiKey' => @api_key, 'Content-Type' => 'application/xml'})
  end
end

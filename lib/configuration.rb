require 'yaml'

class Configuration
  def initialize(config_file = nil)
    @config_file = config_file || ENV['HOME'] + '/.git2mite.yml'
    if File.exist?(@config_file)
      @config = load_config
    else
      @config = {}
    end
  end
  
  def api_key
    @config[:api_key]
  end
  
  def api_key=(value)
    @config[:api_key] = value
    store_config
  end
  
  private
  
  def store_config
    File.open(@config_file, 'w') do |f|
      f << @config.to_yaml
    end
  end
  
  def load_config
    YAML.load(File.read(@config_file))
  end
end

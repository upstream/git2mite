# TODO
# * check if api key is valid
# * run as post commit hook?

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'configuration'
require 'user'
require 'mite_client'
require 'gui'
require 'git_repo'

module Git2Mite
  class App
    def configuration
      @configuration ||= Git2Mite::Configuration.new
    end

    def get_api_key
      configuration.api_key ||= @gui.ask('What is your api key?').strip
    end
  
    def get_sub_domain
      configuration.sub_domain ||= @gui.ask('What is your account subdomain?').strip
    end

    def check_if_git_repo!
      @gui.error "Please change to a directory that is a git repository." unless @repo.is_git_repo?
    end

    def check_ruby_version!
      @gui.error "Sorry you need Ruby 1.8.7+ for this." if RUBY_VERSION < '1.8.7'
    end
  
  
    def initialize
      @gui = Gui.new
      @repo  = GitRepo.new
    end
    
    def run
      @gui.print_welcome
      check_if_git_repo!
      check_ruby_version!
      client = MiteClient.new("http://#{get_sub_domain}.mite.yo.lk", get_api_key)
      project_id = @gui.get_project_id(client.projects)
      user_id = @gui.get_user_id(User.all(client))
      start_date = @gui.get_date('start date')
      end_date = @gui.get_date('end date')
      commits = @repo.commits start_date, end_date
      author = @gui.get_author commits.map{|date, message, _author| _author}.uniq

      puts
      puts 'Writing commits to mite'

      commits.each do |date, message, _author|
        next unless _author == author
        entries = client.time_entries project_id, user_id, date
        if entries.empty?
          STDERR.puts "WARN no time entries for commit #{date.to_s}: #{message}"
        else
          entry = entries[rand(entries.size)]['time_entry']
          client.add_message_to_entry entry, message
          print "."
        end
      end
      puts 'done'
    end
  end
end

Git2Mite::App.new.run

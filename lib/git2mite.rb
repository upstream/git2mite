# TODO
# * check if api key is valid
# * run as post commit hook?

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'configuration'
require 'user'
require 'mite_client'
require 'gui'
require 'git_repo'


def configuration
  @configuration ||= Git2Mite::Configuration.new
end

def get_api_key
  configuration.api_key || configuration.api_key = gui.ask('What is your api key?')
end

def check_if_git_repo!(repo, gui)
  gui.error "Please change to a directory that is a git repository." unless repo.is_git_repo?
end

def check_ruby_version!(gui)
  gui.error "Sorry you need Ruby 1.9 for this." if RUBY_VERSION < '1.9.1'
end

gui = Git2Mite::Gui.new
repo  = Git2Mite::GitRepo.new

gui.print_welcome
check_if_git_repo!(repo, gui)
check_ruby_version!(gui)
client = Git2Mite::MiteClient.new('http://upstream.mite.yo.lk', get_api_key)
project_id = gui.get_project_id(client.projects)
user_id = gui.get_user_id(Git2Mite::User.all(client))
start_date = gui.get_date('start date')
end_date = gui.get_date('end date')
commits = repo.commits start_date, end_date
author = gui.get_author commits.map{|date, message, _author| _author}.uniq

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

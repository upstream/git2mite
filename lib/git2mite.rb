# TODO
# * check if api key is valid
# * run as post commit hook?

$LOAD_PATH.unshift File.dirname(__FILE__)
require 'git2mite/app'
require 'git2mite/configuration'
require 'git2mite/user'
require 'git2mite/mite_client'
require 'git2mite/gui'
require 'git2mite/git_repo'


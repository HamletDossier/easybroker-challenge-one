require 'bundler/setup'
require 'httparty'
require 'dotenv/load'
require_relative 'controllers/easybroker_controller'

controller = EasybrokerController.new

titles = controller.get_titles_from_properties(1,50)

titles.each do |property|
    puts property
end
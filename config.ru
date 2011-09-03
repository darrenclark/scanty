require 'rubygems'
require 'sinatra'
require 'sprockets'

map '/' do
	set :views,	File.join(File.dirname(__FILE__), 'views')
	set :run,	false
	set :env,	ENV['RACK_ENV']

	require 'main'
	run Sinatra::Application
end

map '/assets' do
	sprockets_env = Sprockets::Environment.new
	sprockets_env.append_path 'assets/javascripts'
	sprockets_env.append_path 'assets/stylesheets'
	run sprockets_env
end

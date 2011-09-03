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
    class NoCacheSprockets < Sprockets::Environment
        def find_asset(path, options = {})
            self.class.superclass.superclass.instance_method(:find_asset).bind(self).call(path, options)
        end
        
        def not_modified?(asset,env)
            false
        end
    end
    
	sprockets_env = settings.environment == :development ? NoCacheSprockets.new : Sprockets::Environment.new
	sprockets_env.append_path 'assets/javascripts'
	sprockets_env.append_path 'assets/stylesheets'
	run sprockets_env
end

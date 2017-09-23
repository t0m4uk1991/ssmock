require 'require_all'
require File.open(File.join(File.dirname(__FILE__), 'config/conf_loader.rb'))
require_all 'scripts'

namespace :smock do

	desc "generate scripts"
	task :generate do
		mocks = Conf.config['mocks']
		mocks.each do |mock|
   		name = mock['name']
			port = mock['port']

			endpoints_template = '';

			endpoints = mock['endpoints']
			endpoints.each do |endpoint|
				path = endpoint['endpoint']
				payload = endpoint['payload']
				method = endpoint['method']


				endpoint_template = %{
					#{method} '#{path}' do
							content_type :json
							File.read('public/#{payload}')
						end
					}


				endpoints_template = endpoints_template + endpoint_template + "\n"

			end


			templates = {}

			templates[name] = %{
				require 'sinatra'

				set :public_folder, 'public'
				set :port, #{port}

				File.write("./scripts/\#{Process.pid}.pid", Process.pid)

				#{endpoints_template}
			}

			puts templates

			File.write("./scripts/#{name}.rb", templates[name])

		end
	end

	desc "run scripts"
	task :run do
  		Dir.entries('scripts').each do |script|
				ruby 'scripts/'+script+' >> log/access.log 2>&1 &' if File.fnmatch('**.rb', script)
			end
	end

	desc "kill mocks"
	task :kill do
		pids = []
		Dir.entries('scripts').each do |pid|
			pids << pid.split('.')[0] if File.fnmatch('**.pid', pid)
		end

		Dir.entries('scripts').each do |file|
			File.delete('./scripts/' + file) if File.fnmatch('**.pid', file) || File.fnmatch('**.rb', file)
		end

		pids.each do |pid|
			begin
				Thread.new do
				  begin
						`kill -9 #{pid}`
					rescue => e
		    		puts e.inspect
				  end
				end
			rescue => e
    		puts e.inspect
		  end
		end

	end

end

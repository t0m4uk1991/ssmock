require 'rubygems'
require 'yaml'

class Conf
	@@config = YAML::load(File.open(File.join(File.dirname(__FILE__), 'mock.yml')))
	def self.config
		@@config
	end
end

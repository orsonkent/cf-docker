#!/usr/bin/ruby

require 'rubygems'
require 'nats/client'
require 'yaml'

#["TERM", "INT"].each { |sig| trap(sig) { NATS.stop } }

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'cf-docker.yaml'))
nats_config=config['component']['nats']

natsuser=nats_config['username']
natspass=nats_config['password']
natshost=nats_config['host']
natsport=nats_config['port']
natssubject="test.load"
natsmessage="this is a test message load"

uri = "nats://#{natsuser}:#{natspass}@#{natshost}:#{natsport}"

NATS.on_error { |err| abort(red("Server Error: #{err}")) }

puts green("starting NATS test against #{natshost}")

NATS.start(:uri => uri) {
  	puts green("subscribing...")
  	NATS.subscribe(natssubject) do |msg, reply, natssubject|
    	puts green("received data on sub:#{natssubject} - #{msg}")
    	NATS.stop
  	end
  	puts green("publishing...")
	NATS.connect(:uri => uri) { |nc| nc.publish(natssubject, natsmessage) }  
}

puts green("NATS subscription and publication test successful against host #{natshost}")


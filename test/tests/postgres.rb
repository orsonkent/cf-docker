#!/usr/bin/ruby

require 'rubygems'
require 'yaml'
require 'pg'

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def yellow(text); colorize(text, 33); end
def green(text); colorize(text, 32); end

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'cf-docker.yaml'))

#pg_config=config['component']['postgres']

pguser=config['component']['postgres']['username']
pgpass=config['component']['postgres']['password']
pghost=config['component']['postgres']['host']
pgport=config['component']['postgres']['port']
puts green("starting PostgreSQL test against #{pghost}")
begin
	conn = PG::Connection.open(:host => pghost, :port => pgport, :dbname => 'docker', :user => pguser, :password => pgpass)
rescue
	puts red("Failed to connect to database.")
	exit 1
end

begin
	puts green("Deleting test table from previous test run (if it exists, which it shouldn't)")
    conn.exec("DROP TABLE IF EXISTS test;")
rescue PG::Error => e
	puts yellow("#{e}")
end

begin
	puts green("Creating test table")
    conn.exec_params("CREATE TABLE IF NOT EXISTS test (testentry varchar(40));")
    puts green("Inserting into test table")
    conn.exec_params("INSERT into test (testentry) VALUES ('this is a test');")
rescue PG::Error => e
    puts red("Error creating and filling test table.")
    puts red("#{e}")
    conn.exec("DROP TABLE IF EXISTS test;")
   	exit 1
end

begin
	puts green("Selecting from test table")
	conn.exec( "SELECT * FROM test;" ) do |result|
		result.each do |row|
			row.each do
				puts green(row)
			end
		end
	end
rescue PG::Error => e
	puts red("Select failed.")
	puts red("#{e}")
    exit 1
end

begin
	puts green("dropping test table")
	conn.exec("drop table test;")
	puts green("Closing connection")
	conn.close() if conn
rescue PG::Error => e
	puts yellow("#{e}")
end

#!/usr/bin/ruby

test_list=['nats']

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end

test_list.each {
	|test| result = system("/vcap/tests/#{test}.rb 2>&1")
	if result == true
		puts green("#{test} test completed successfully")
	else
		puts red("#{test} test failed")
	end
}
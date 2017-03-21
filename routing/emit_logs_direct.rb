#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

connection = Bunny.new(:automatically_recover => false)
connection.start

channel       = connection.create_channel
exchange        = channel.direct('direct_logs')
severity = ARGV.shift || 'info' # Default to info is not error is provided in as ARGV
msg      = ARGV.empty? ? 'Hello World!' : ARGV.join(' ') # Default to 'Hello World!' if no message is present

exchange.publish(msg, :routing_key => severity) # Attach routing_key so as to publish in the correct queue
puts " [x] Sent '#{msg}'"

connection.close
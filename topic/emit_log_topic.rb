#!/usr/bin/env ruby
# encoding: utf-8

require 'bunny'

connection = Bunny.new(:automatically_recover => false)
connection.start

channel       = connection.create_channel
exchange        = channel.topic('topic_logs')
severity = ARGV.shift || 'anonymous.info' # Default to anonymous.info
msg      = ARGV.empty? ? 'Hello World!' : ARGV.join(' ') # Default to 'Hello World!'

exchange.publish(msg, :routing_key => severity) # Attach routing_key so as to publish in the correct queue
puts " [x] Sent #{severity}: #{msg}"

connection.close
require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
exchange = channel.fanout('logs') # Uses newly created channel to broadcast to all consumers

msg = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

exchange.publish(msg)
puts " [x] Sent #{msg}"

connection.close
require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
q = channel.queue('hello')
channel.default_exchange.publish('Hello World!', :routing_key => q.name)
puts ' [x] Sent "Hello World!"'
connection.close
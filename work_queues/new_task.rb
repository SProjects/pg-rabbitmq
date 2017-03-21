require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
q = channel.queue('hello')

msg = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
q.publish(msg, :persistent => true)
puts " [x] Sent #{msg}"
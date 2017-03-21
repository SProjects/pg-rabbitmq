require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
q = channel.queue('hello')

puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
q.subscribe(:block => true) do |delivery_info, properties, body|
  puts " [x] Received #{body}"

  delivery_info.consumer.cancel
end
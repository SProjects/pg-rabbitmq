require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
q = channel.queue('task_queue', :durable => true)

channel.prefetch(1) # Ensures RabbitMQ only dispatches msgs to workers that aren't busy. 1 is the No. of messages
puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"

begin
  q.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
    puts " [x] Received #{body}"

    sleep body.count('.').to_i
    puts " [x] Done"
    channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  connection.close
end
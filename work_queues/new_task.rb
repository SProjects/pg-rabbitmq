require 'bunny'

connection = Bunny.new
connection.start

channel = connection.create_channel
q = channel.queue('task_queue', :durable => true) #Can another queue name is required because hello was not initially
                                                  # declared as durable. This makes RabbitMQ remember the queue in case
                                                  # of failure or quiting

msg = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
q.publish(msg, :persistent => true) #Ensures the messages will be persisted on RabbitMQ in case of restart or failure.
puts " [x] Sent #{msg}"
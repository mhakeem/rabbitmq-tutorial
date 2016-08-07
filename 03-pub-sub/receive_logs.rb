# encoding: utf-8
#!/usr/bin/env ruby

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

ch = conn.create_channel
x = ch.fanout("logs")
# empty string means connect to a fresh new random queue
# exclusive means to create non-durable queue (auto delete once disocnnected)
q = ch.queue("", exclusive: true)

# bind means to connect our fanout exchange to our queue
q.bind(x)

puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(block: true) do |delivery_info, properties, body|
    puts " [X] #{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end

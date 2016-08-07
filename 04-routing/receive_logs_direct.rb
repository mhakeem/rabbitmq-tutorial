# encoding: utf-8
#!/usr/bin/env ruby

require "bunny"
require_relative "../config/rabbitmq"

if ARGV.empty?
  abort "Usage: #{$0} [info] [warning] [error]"
end

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

ch = conn.create_channel
x  = ch.direct("direct_logs")
q  = ch.queue("", exclusive: true)

ARGV.each do |severity|
  q.bind(x, routing_key: severity)
end

puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(block: true) do |delivrey_info, properties, body|
    puts " [x] #{delivrey_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end

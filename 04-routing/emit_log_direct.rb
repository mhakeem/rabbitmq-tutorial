# encoding: utf-8
#!/usr/bin/env ruby

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

ch       = conn.create_channel
# we're using "direct" exchange to communicate w/ queues w/ a specific binding key
x        = ch.direct("direct_logs")
severity = ARGV.shift || "info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg, routing_key: severity)
puts " [x] Sent '#{msg}'"

conn.close

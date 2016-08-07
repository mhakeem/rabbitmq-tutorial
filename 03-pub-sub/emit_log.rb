# encoding: utf-8
#!/usr/bin/env ruby

require "bunny"
require_relative "../config/environment"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

ch = conn.create_channel
# "fanout" exchange is used to broadcast messages to all queues
x = ch.fanout("logs")

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg)
puts " [X] Sent #{msg}"

conn.close

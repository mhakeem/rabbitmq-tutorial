#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

ch       = conn.create_channel
# we're using "topic" exchange to send messages to queues based on matching binding keys
x        = ch.topic("topic_logs")
severity = ARGV.shift || "anonymous.info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg, :routing_key => severity)
puts " [x] Sent #{severity}:#{msg}"

conn.close
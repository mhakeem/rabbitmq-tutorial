#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

# channel
ch = conn.create_channel
q = ch.queue("hello")

ch.default_exchange.publish("Hello World!", routing_key: q.name)
puts " [X] Sent 'Hello World!'"

conn.close

#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/environment"

conf = {
  host:     ENV['RABBITMQ_IP'],
  user:     ENV['RABBITMQ_USER'],
  password: ENV['RABBITMQ_PASS']
}

conn = Bunny.new(conf)
conn.start

# channel
ch = conn.create_channel
q = ch.queue("hello")

ch.default_exchange.publish("Hello World!", routing_key: q.name)
puts " [X] Sent 'Hello World!'"

conn.close

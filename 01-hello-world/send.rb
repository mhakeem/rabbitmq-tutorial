#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/environment"

REMOTE_IP = ENV['RABBITMQ_IP']
USER      = ENV['RABBITMQ_USER']
PASS      = ENV['RABBITMQ_PASS']

conn = Bunny.new(host: REMOTE_IP, user: USER, password: PASS)
conn.start

# channel
ch = conn.create_channel
q = ch.queue("hello")

ch.default_exchange.publish("Hello World!", routing_key: q.name)
puts " [X] Sent 'Hello World!'"

conn.close

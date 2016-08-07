#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

# channel
ch = conn.create_channel
# use "durable" to not lose messages in queue if RabbitMQ crashes
q = ch.queue("task_queue", durable: true)

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

# marking messages as "persistent" if support durabilty
# and not lose messages when the server crashes
q.publish(msg, persistent: true)
puts " [X] Sent #{msg}"

sleep 1.0
conn.close

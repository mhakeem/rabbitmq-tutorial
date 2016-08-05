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
# use "durable" to not lose messages in queue if RabbitMQ crashes
q = ch.queue("task_queue", durable: true)

msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

# marking messages as "persistent" if support durabilty
# and not lose messages when the server crashes
q.publish(msg, persistent: true)
puts " [X] Sent #{msg}"

sleep 1.0
conn.close

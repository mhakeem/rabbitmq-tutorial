#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

# channel
ch = conn.create_channel
q = ch.queue("task_queue", durable: true)

# to ensure that each worker gets one message at a time and not
# overworking one worker over the other.
ch.prefetch(1)
puts " [*] Waiting for messages. To exit press CTRL+C"

begin
  # manual_ack is to ensure that if a wokrer crashes, the message
  # is not lost and is handed to another active worker.
  q.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
    puts " [X] Received #{body}"

    # immitate some work
    sleep 1.0
    ch.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  conn.close
  exit(0)
end

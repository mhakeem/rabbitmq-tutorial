#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "environment"

REMOTE_IP = ENV['RABBITMQ_IP']
USER      = ENV['RABBITMQ_USER']
PASS      = ENV['RABBITMQ_PASS']

conn = Bunny.new(host: REMOTE_IP, user: USER, password: PASS)
conn.start

# channel
ch = conn.create_channel
q = ch.queue("hello")

begin
  puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
  q.subscribe(block: true) do |delivery_info, properties, body|
    puts "[X] Received #{body}"

    puts "properties: #{properties}"
    puts "delivery_info: #{delivery_info}"

    # cancel the consumser to exit
    delivery_info.consumer.cancel
  end
rescue Interrupt => _
  conn.close
  exit(0)
end

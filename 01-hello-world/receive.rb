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

begin
  puts " [*] Waiting for messages in #{q.name}. To exit press CTRL+C"
  q.subscribe(block: true) do |delivery_info, properties, body|
    puts " [X] Received #{body}"

    # puts "properties: #{properties}"
    # puts "delivery_info: #{delivery_info}"

    # cancel the consumser to exit
    delivery_info.consumer.cancel
  end
rescue Interrupt => _
  conn.close
  exit(0)
end

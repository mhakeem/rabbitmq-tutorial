#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require_relative "../config/rabbitmq"

conn = Bunny.new(Config::RabbitMQ::CONF)
conn.start

ch = conn.create_channel

class FibonacciClient
  attr_reader :reply_queue, :lock, :condition
  attr_accessor :response, :call_id

  def initialize(ch, server_queue)
    @ch           = ch
    @x            = ch.default_exchange

    @server_queue = server_queue
    @reply_queue  = ch.queue("", exclusive: true)

    @lock      = Mutex.new
    @condition = ConditionVariable.new
    that       = self

    @reply_queue.subscribe do |delivery_info, properties, payload|
      if properties[:correlation_id] == that.call_id
        that.response = payload.to_i
        that.lock.synchronize{that.condition.signal}
      end
    end
  end
    
  def call(n)
    self.call_id = self.generate_uuid

    @x.publish(n.to_s,
               routing_key: @server_queue,
               correlation_id: call_id,
               reply_to: @reply_queue.name)
    lock.synchronize{condition.wait(lock)}
    response
  end

  protected

  def generate_uuid
    "#{rand}#{rand}#{rand}"
  end
end

client = FibonacciClient.new(ch, "rpc_queue")
puts " [x] Requesting fib(40)"
response = client.call(40)
puts " [.] Got #{response}"

ch.close
conn.close

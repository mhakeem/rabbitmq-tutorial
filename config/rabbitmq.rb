module Config
  module RabbitMQ
    CONF = {
      host:     ENV['RABBITMQ_IP'],
      user:     ENV['RABBITMQ_USER'],
      password: ENV['RABBITMQ_PASS']
    }
  end
end
Implementation of RabbitMQ examples using Bunny gem (https://www.rabbitmq.com/getstarted.html).

**Used the following versions:**
- RabbitMQ 3.6.4
- Ruby 2.3.1
- [Bunny](https://github.com/ruby-amqp/bunny) gem 2.5.0

### Important
Add an environment file and name it `environment.rb` under the `config` folder, and add the following:
```ruby
# ENV['RABBITMQ_IP']   = "YOU IP ADDRESS"
# ENV['RABBITMQ_USER'] = "USER"
# ENV['RABBITMQ_PASS'] = "PASS"

# example
ENV['RABBITMQ_IP']   = "127.0.0.1"
ENV['RABBITMQ_USER'] = "guest"
ENV['RABBITMQ_PASS'] = "guest"
```

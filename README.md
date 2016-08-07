Implementation of RabbitMQ examples using Bunny gem (https://www.rabbitmq.com/getstarted.html).

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
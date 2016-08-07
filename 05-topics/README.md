- To receive all the logs:
`ruby receive_logs_topic.rb "#"`

- To receive all logs from the facility "kern":
`ruby receive_logs_topic.rb "kern.*"`

- Or if you want to hear only about "critical" logs:
`ruby receive_logs_topic.b "*.critical"`

- You can create multiple bindings:
`ruby receive_logs_topic.rb "kern.*" "*.critical"`

- And to emit a log with a routing key "kern.critical" type:
`ruby emit_log_topic.rb "kern.critical" "A critical kernel error"`


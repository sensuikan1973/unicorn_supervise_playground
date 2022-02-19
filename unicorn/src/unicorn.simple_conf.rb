# See: https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.minimal.rb
# See: https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.rb

worker_processes 2

stderr_path './unicorn_stderr.log'
stdout_path './unicorn_stdout.log'

pid 'unicorn.pid'

listen 8080, :tcp_nopush => true

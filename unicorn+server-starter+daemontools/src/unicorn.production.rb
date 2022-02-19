# See: https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.minimal.rb
# See: https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.rb

worker_processes 40

stderr_path './unicorn_stderr.log'
stdout_path './unicorn_stdout.log'

status_file = "/sample/sample_server.status"

preload_app true

listen "/sample/unicorn.sock", backlog: 2048

timeout 7

# use correct Gemfile on restarts
before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = "/sample/src/Gemfile"
end

if ENV.key?('SERVER_STARTER_PORT')
  fds = ENV['SERVER_STARTER_PORT'].split(';').map { |pair|
    _path_or_port, fd = pair.split('=', 2)
    fd
  }
  ENV['UNICORN_FD'] = fds.join(',')
  ENV.delete('SERVER_STARTER_PORT')
else
  listen ENV['PORT'] || '10080'
end

before_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection

  begin
    # This allows a new master process to incrementally
    # phase out the old master process with SIGTTOU to avoid a
    # thundering herd (especially in the "preload_app false" case)
    # when doing a transparent upgrade.  The last worker spawned
    # will then kill off the old master process with a SIGQUIT.
    pids = File.readlines(status_file).map { |line| line.chomp.split(':') }.to_h
    old_gen = ENV['SERVER_STARTER_GENERATION'].to_i - 1
    old_pid = pids[old_gen.to_s]
    $stdout.puts "old_gen #{old_gen}, old_pid: #{old_pid}"
    if old_pid
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, old_pid.to_i)
    end
  rescue Errno::ENOENT, Errno::ESRCH => e
    $stderr.puts "#{e.class} #{e.message}"
  end
end

# See: https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.minimal.rb
# See: https://github.com/defunkt/unicorn/blob/master/examples/unicorn.conf.rb

worker_processes 2

stderr_path './unicorn_stderr.log'
stdout_path './unicorn_stdout.log'

pid '/sample/unicorn.pid'

listen 8080, :tcp_nopush => true

# See: https://github.com/defunkt/unicorn/blob/93e154e16b87f943a20fa720e002c67c9d17c30b/examples/unicorn.conf.rb#L71
before_fork do |server, worker|
  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.

  # This allows a new master process to incrementally
  # phase out the old master process with SIGTTOU to avoid a
  # thundering herd (especially in the "preload_app false" case)
  # when doing a transparent upgrade.  The last worker spawned
  # will then kill off the old master process with a SIGQUIT.
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  sleep 1
end

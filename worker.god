God.watch do |w|
  w.name     = "aftonbladet-most-read"
  w.group    = "aftonbladet"
  w.interval = 60.seconds
  w.dir      = File.dirname(__FILE__)
  
  w.start = "/usr/local/rvm/bin/webmaster_ruby worker.rb"
  
  # Delay for X seconds on start/stop
  w.start_grace = 5.seconds
  w.stop_grace  = 5.seconds
  
  # User / group
  w.uid = "webmaster"
  w.gid = "webmaster"
  
  w.log = "/tmp/aftonbladet-most-read.log"
  
  # Monitoring:
  w.start_if do |start|
    start.condition(:process_running) { |c| c.running = false }
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 50.megabytes
      c.times = [3, 5]
    end
    
    restart.condition(:cpu_usage) do |c|
      c.above = 95.percent
      c.times = 5
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times    = 5
      c.within   = 5.minutes
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
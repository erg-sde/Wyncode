class TimeOutError < StandardError
  puts "Request timed out."
end

host_port = 8888

def recvfrom host_port
end

def listen host_port
  start = Time.new
  begin
    data = recvfrom(host_port) 
  end while (Time.new - start < 1)
  if data.nil?
    raise TimeOutError
  else
    data
  end
end
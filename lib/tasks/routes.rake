desc 'Print compiled grape routes'
task :routes do
  BrightSound::API.routes.each do |api|
    method = api.request_method.ljust(10)
    path = api.path
    puts "     #{method} #{path}"
  end
end

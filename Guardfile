guard 'bundler' do
  watch('Gemfile')
end

guard 'rack', port: 9292 do
  watch('Gemfile.lock')
  watch(%r{^(config|lib|app)/.*})
end

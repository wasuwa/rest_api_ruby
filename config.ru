require_relative 'lib/users'

run Rack::Cascade.new([Users])

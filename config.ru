require_relative 'lib/user'

run Rack::Cascade.new([User])

require 'grape'

class User < Grape::API
  format :json
  @@users = []

  get '/users' do
    if @@users.empty?
      status 404
      { message: 'Not Found User' }
    else
      status 200
      @@users
    end
  end
end

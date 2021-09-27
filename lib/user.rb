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

  post '/users' do
    if params[:name] && params[:age]
      id = @@users.size + 1
      user = { id: id, name: params[:name], age: params[:age] }
      @@users << user
      status 201
      user
    else
      status 400
      { message: "'name' and 'age' must be required" }
    end
  end
end

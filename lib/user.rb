require 'grape'

class User < Grape::API
  format :json
  @@users = []

  get '/users' do
    if @@users.empty?
      status 404
      { message: 'Not Found Users' }
    else
      status 200
      @@users
    end
  end

  get '/users/:id' do
    index = params[:id].to_i - 1

    if @@users[index]
      status 200
      @@users[index]
    else
      status 404
      { message: "Not Found User id: #{params[:id]}" }
    end
  end

  post '/users' do
    name = params[:name]
    age  = params[:age]

    if name && age
      id = @@users.size + 1
      user = { id: id, name: name, age: age }
      @@users << user
      status 201
      user
    else
      status 400
      { message: "'name' and 'age' must be required" }
    end
  end

  patch '/users/:id' do
    name  = params[:name]
    age   = params[:age]
    index = params[:id].to_i - 1
    user  = @@users[index]

    if user.nil?
      status 404
      return { message: "Not Found User id: #{params[:id]}" }
    end

    unless name && age
      status 400
      { message: "'name' or 'age' must be required" }
    end

    user[:name] = name if name
    user[:age]  = age  if age
    status 200
    user
  end
end

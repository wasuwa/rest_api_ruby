require 'grape'

class Users < Grape::API
  format :json
  @@users = []

  helpers do
    def not_found_user(id)
      status 404
      { message: "Not Found User id: #{id}" }
    end

    def name_age_must_be_required(message)
      status 400
      { message: "'name' #{message} 'age' must be required" }
    end

    def users_index(id)
      id.to_i - 1
    end
  end

  get '/' do
    status 301
    redirect '/users'
  end

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
    index = users_index(params[:id])

    if @@users[index]
      status 200
      @@users[index]
    else
      not_found_user(params[:id])
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
      name_age_must_be_required('and')
    end
  end

  patch '/users/:id' do
    name  = params[:name]
    age   = params[:age]
    index = users_index(params[:id])
    user  = @@users[index]

    unless user
      return not_found_user(params[:id])
    end

    unless name && age
      return name_age_must_be_required('or')
    end

    user[:name] = name if name
    user[:age]  = age  if age
    status 200
    user
  end

  put '/users/:id' do
    name  = params[:name]
    age   = params[:age]
    index = users_index(params[:id])
    user  = @@users[index]

    if user.nil?
      return not_found_user(params[:id])
    end

    if name.nil? || age.nil?
      return name_age_must_be_required('and')
    end

    user[:name], user[:age] = name, age
    status 200
    user
  end

  delete 'users/:id' do
    index = users_index(params[:id])
    user = @@users[index]

    unless user
      return not_found_user(params[:id])
    end

    status 204
    @@users.delete(user)
    nil
  end
end

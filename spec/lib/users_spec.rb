require 'spec_helper'
require 'rack/test'

RSpec.describe Users do
  include Rack::Test::Methods

  def app
    Users.new
  end

  describe 'GET /' do
    context 'レスポンスが成功した場合' do
      it '302ステータスコードを返すこと' do
        get '/'
        expect(last_response.status).to eq 302
      end
    end
  end

  describe 'GET /users' do
    before { get '/users' }

    context 'ユーザーが存在する場合' do
      before do
        json = '{ "name": "もこう", "age": 30 }'
        post '/users', json, 'CONTENT_TYPE' => 'application/json'
        puts last_response.body
      end

      it '200ステータスコードを返すこと' do
        get '/users'
        expect(last_response.status).to eq 200
      end
    end

    context 'ユーザーが存在しない場合' do
      it '404ステータスコードを返すこと' do
        expect(last_response.status).to eq 404
      end

      it "エラーメッセージを返すこと" do
        error_message = JSON.parse(last_response.body)['message']
        expect(error_message).to eq 'Not Found Users'
      end
    end
  end
end

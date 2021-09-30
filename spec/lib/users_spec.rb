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
    before do
      get '/users'
    end

    context 'ユーザーが存在しない場合' do
      it '404ステータスコードを返すこと' do
        expect(last_response.status).to eq 404
      end
    end
  end
end

require 'spec_helper'
require 'rack/test'

RSpec.describe Users do
  include Rack::Test::Methods

  def app
    Users.new
  end

  describe 'GET /' do
    context 'レスポンスが成功した場合' do
      it 'ステータスコードが302を返すこと' do
        get '/'
        expect(last_response.status).to eq 302
      end
    end
  end
end

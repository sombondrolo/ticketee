require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  let(:admin) { FactoryBot.create(:user, :admin) }

  describe "GET /users >" do
    before do
      login_as(admin)
    end

    it "returns http success" do
      get "/admin/users"
      expect(response).to have_http_status(:success)
    end
  end
end

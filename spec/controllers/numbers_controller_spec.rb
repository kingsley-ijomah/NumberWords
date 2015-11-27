require 'rails_helper'

RSpec.describe NumbersController, type: :controller do
	describe 'GET #index' do
		it "returns http success" do
	    get :index
	    expect(response).to have_http_status(:success)
	  end

	  it 'assigns Number.all to @numbers' do
			numbers = double('numbers')
			page = double('page')
			allow(Number).to receive(:all).and_return(numbers)

			get 'index'

			expect(Number).to have_received(:all)
			expect(assigns[:numbers]).to eq numbers
		end
	end
end
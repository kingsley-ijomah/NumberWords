class NumbersController < ApplicationController
  def index
    @numbers = Number.all(params[:page])
  end
end

class PageController < ApplicationController
  def index
    @products = Product.all
  end
end

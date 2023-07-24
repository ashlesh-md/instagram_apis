class Api::V1::ProductsController < ApplicationController
    def get_products
        render json: ProductApiService.fetch_products
    end 
end

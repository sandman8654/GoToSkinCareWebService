class ProductController < ApplicationController
  def list
    result_hash = {}
    result_hash[:success]=true
    result_hash[:message]=""
    @products = Product.all
    if @products
      product_array=[]
      @products.each do |product|
        product_array.push(getProductInfo(product))
      end
      result_hash[:products]=product_array
    end
    require 'json'
    render json:JSON(result_hash)
  end
  private
  def getProductInfo(product)
    productinfo={}
    productinfo[:productName] = product.name
    productinfo[:productId] = product.id
    productinfo[:price] = product.price
    productinfo[:detail] = product.detail
    productinfo[:imageUrlSmall] = product.image_url_small
    productinfo[:imageUrlMedium] = product.image_url_medium
    productinfo[:imageUrlLarge] = product.image_url_large
    currency = Currency.find_by(id: product.price_currency_id )
    productinfo[:priceCurrency] = currency.name
    productinfo[:priceCurrencySymbol] = currency.symbol
    return productinfo
  end

end

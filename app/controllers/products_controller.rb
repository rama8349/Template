class ProductsController < ApplicationController
  def index
    #binding.pry
    conditions = ""

    if params[:product]
    params[:product].each do |k,v|
      conditions  = "#{k} like '%#{v}%' " unless v.empty? 
      #b#inding.pry
      #conditions << conditions + 'and'  if !conditions[0].blank? || !conditions[conditions.length-1].blank?
    end
    end
    # binding.pry
    conditions = nil || conditions
    
    #binding.pry
  	 @products = Product.where(conditions).order(params[:sort]).paginate(:page => params[:page], :per_page => 2)
    #binding.pry
    respond_to do |format|
      format.js 
      format.html 
    end
  end

  def new
  	@product=Product.new  	
  end

  def create
  	@product = Product.new(product_params) 
  	if @product.save
  		ProductMailer.with(product: @product).new_product_email.deliver_now
  		ProductWorker.perform_async(@product)
  		flash[:notice] = "yes"
  		redirect_to products_path
  	else
  		flash[:error] = 'No'
  		render new_product_path
  	end
  end

  def edit
  	@product = Product.find(params[:id])
  end

  def update
  	binding.pry
  	@product = Product.find_by(params[:id]) 
  	if @product.update(product_params)
  		ProductMailer.with(product: @product).new_product_email.deliver_now
  		ProductWorker.perform_async(@product)
  		flash[:notice] = "yes"
  		redirect_to products_path
  	else
  		flash[:error] = 'No'
  		render :edit
  	end
  end

  def show
  	@product = Product.find(params[:id])
  end

  private

  def product_params
  	   params.require(:product).permit(:name, :price, :description, :manufacture_year)
  end
end

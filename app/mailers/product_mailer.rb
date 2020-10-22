class ProductMailer < ApplicationMailer
	def new_product_email		
		@product = params[:product]
		mail(to: 'rama1241@gmail.com', subject: "You got a new order!")
	end
end

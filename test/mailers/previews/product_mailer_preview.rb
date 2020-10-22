# Preview all emails at http://localhost:3000/rails/mailers/product_mailer
class ProductMailerPreview < ActionMailer::Preview
	def new_product_email
    # Set up a temporary order for the preview
    product = Product.new(name: "Joe Smith", price: '20.0')

    ProductMailer.with(product: product).new_product_email
end
end

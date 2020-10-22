class ProductWorker
  include Sidekiq::Worker
  #sidekiq_options retry: false

  def perform(product)
  	binding.pry
    puts "Do something #{@product.name}"
  end

end

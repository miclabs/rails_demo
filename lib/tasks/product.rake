namespace :product do
  desc "Async all products from API Store"
  task async_all_products: :environment do
  	puts "==== Start async ===="

    # Account:  tanngoc93@gmail.com
    # Password: 1qazxsw2
    # ====================================================================
    # Shopify store URL  => https://mic-test-rest-api.myshopify.com/
    # Shopify store Amin => https://mic-test-rest-api.myshopify.com/admin/

  	ShopifyAPI::Base.site = "https://#{ENV['SHOPIFY_API_KEY']}:#{ENV['SHOPIFY_PASSWORD']}@#{ENV['SHOPIFY_APP_NAME']}.myshopify.com/admin"
  	
  	counter  = 0
  	products = ShopifyAPI::Product.all

  	products.each do |p|
  		product = Product.find_or_create_by(product_id: p.id)

  		product.update(
  			body_html:                   p.body_html,
  			handle:                      p.handle,
  			images:                      p.images,
  			options:                     p.options,
  			product_type:                p.product_type,
  			published_at:                p.published_at,
  			published_scope:             p.published_scope,
  			tags:                        p.tags,
  			template_suffix:             p.template_suffix,
  			title:                       p.title,
  			variants:                    p.variants,
        metafields_global_title_tag: metafields_global_title_tag(p), # Only for Shopify Plus store
  			vendor:           					 p.vendor
  		)
  		
  		counter += 1 if product.save!
  	end

  	puts "==== There are #{counter} products that have been synchronized ===="
  	puts "==== End async ===="
  end

  def metafields_global_title_tag(product)
    product.has_attribute?('metafields_global_title_tag') ? 
                      product.metafields_global_title_tag : nil
  end
end

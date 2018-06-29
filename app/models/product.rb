class Product < ApplicationRecord
	def price_from
		prices = self.variants.pluck('price').map { |p| p.to_i }.sort
		return "Price from $#{prices.first} to $#{prices.last}"
	end
end

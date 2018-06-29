class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    	t.text     :body_html
    	t.string   :handle
    	t.integer  :product_id, limit: 8, unique: true
    	t.json     :images, array: true
    	t.json	   :options, array: true
    	t.string   :product_type
    	t.datetime :published_at
    	t.string   :published_scope
    	t.string   :tags
    	t.string   :template_suffix
    	t.string   :title
    	t.string   :metafields_global_title_tag # Only for Shopify Plus store
    	t.json     :variants, array: true
    	t.string   :vendor

      t.timestamps
    end
  end
end

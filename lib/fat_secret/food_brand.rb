module FatSecret
  class FoodBrand
    class << self
      def get(starts_with = '', options = {})
        results = Connection.get('food_brands.get', { starts_with: starts_with }.merge(options))

        food_brand_results = []
        unless results['food_brands'].blank?
          food_brand_results = results['food_brands']['food_brand']
        end

        food_brand_results
      end
    end
  end
end

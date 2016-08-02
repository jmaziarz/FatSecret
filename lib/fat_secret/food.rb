module FatSecret
  class Food < Base
    attribute :description, type: String
    attribute :name, type: String
    attribute :type, type: String
    attribute :url, type: String
    attribute :brand_name, type: String

    has_many :servings, autoload: true

    alias :food_id= :id=
    alias :food_description= :description=
    alias :food_name= :name=
    alias :food_type= :type=
    alias :food_url= :url=

    class << self
      def search(search_expression, options = {})
        results = Connection.get(
          'foods.search', default_search_options.
          merge({ search_expression: search_expression }).merge(options)
        )

        food_results = {}
        unless results['foods']['food'].nil?
          food_results = results['foods']['food'].map { |f| new(f) }
        end

        ResultsProxy.new(
          food_results,
          results['foods']['max_results'],
          results['foods']['page_number'],
          results['foods']['total_results']
        )
      end

      def get(food_id)
        new FatSecret::Connection.get('food.get', food_id: food_id)['food']
      end

      private

      def default_search_options
        {
          max_results: 50, page_number: 0
        }
      end
    end
  end
end

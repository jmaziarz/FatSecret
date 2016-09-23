module FatSecret
  class FoodEntry < Base
    attribute :description, type: String
    attribute :name, type: String
    attribute :date, type: Integer
    attribute :meal, type: String
    attribute :food_id, type: Integer
    attribute :serving_id, type: Integer
    attribute :number_of_units, type: Float

    attribute :calories, type: Float
    attribute :carbohydrate, type: Float
    attribute :protein, type: Float
    attribute :fat, type: Float
    attribute :saturated_fat, type: Float
    attribute :polysaturated_fat, type: Float
    attribute :monostaturated_fat, type: Float
    attribute :trans_fat, type: Float
    attribute :cholesterol, type: Float
    attribute :sodium, type: Float
    attribute :potassium, type: Float
    attribute :fiber, type: Float
    attribute :sugar, type: Float
    attribute :vitamin_a, type: Float
    attribute :vitamin_c, type: Float
    attribute :calcium, type: Float
    attribute :iron, type: Float

    alias :food_entry_id= :id=
    alias :food_entry_description= :description=
    alias :food_entry_name= :name=
    alias :date_int= :date=

    class << self

      def get(oauth_token, oauth_secret, date = Date.today)
        entries = FatSecret::Connection.get('food_entries.get', oauth_token: oauth_token, oauth_secret: oauth_secret, date: days_since_epoch(date))

        if entries['food_entries']
          parse_entries(entries['food_entries'])
        end
      end

      private

      def parse_entries(food_entries)
        entries = Array.new

        if food_entries['food_entry'].instance_of?(Hash)
          entries << new(food_entries['food_entry'])
        else
          food_entries['food_entry'].each do |e|
            entries << new(e)
          end
        end

        return entries
      end

      def days_since_epoch(date)
        (date - Date.new(1970,1,1)).to_i
      end
    end
  end
end

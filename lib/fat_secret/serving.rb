module FatSecret
  class Serving < Base

    attribute :description, type: String
    attribute :url, type: String
    attribute :metric_serving_unit, type: String
    attribute :metric_serving_amount, type: Float
    attribute :number_of_units, type: Integer
    attribute :measurement_description, type: String
    attribute :calories, type: Float
    attribute :carbohydrate, type: Float
    attribute :protein, type: Float
    attribute :fat, type: Float
    attribute :saturated_fat, type: Float
    attribute :polyunsaturated_fat, type: Float
    attribute :monounsaturated_fat, type: Float
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

    alias :serving_id= :id=
    alias :serving_description= :description=
    alias :serving_url= :url=

    belongs_to :food

    def serving_measurement
      measurement_from_description
    end

    def serving_multiplier
      serving_units / units_from_description.to_f
    end

    private

    # TODO: DRY *_from_description methods
    def measurement_from_description
      if measurement_description == 'serving'
        description.split(' ', 2)[1]
      else
        measurement_description
      end
    end

    def units_from_description
      if measurement_description == 'serving'
        description.split(' ', 2)[0]
      else
        number_of_units
      end
    end
  end
end

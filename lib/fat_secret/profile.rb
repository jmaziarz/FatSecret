module FatSecret
  class Profile < Base
    attribute :weight_measure, type: String
    attribute :height_measure, type: String
    attribute :last_weight_kg, type: Float
    attribute :last_weight_date_int, type: Integer
    attribute :last_weight_comment, type: String
    attribute :goal_weight_kg, type: Float
    attribute :height_cm, type: Float

    class << self
      def create(user_id = '')
        new FatSecret::Connevction.get('profile.create', user_id: user_id )
      end

      def get(oauth_token = '')
        new FatSecret::Connection.get('profile.get', oauth_token: oauth_token)
      end

      def get_auth(user_id)
        new FatSecret::Connection.get('profile.get_auth', user_id: user_id)
      end
    end
  end
end

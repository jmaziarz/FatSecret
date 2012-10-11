module FatSecret
  module Relations
    module HasMany
      extend ActiveSupport::Concern

      module ClassMethods
        def has_many(type, options = {})

          define_method type do
            @servings ||= HasManyProxy.new([])
            if options[:autoload] && @servings.blank? && id
              self.class.get(id).servings
            else
              @servings
            end
          end

          define_method "#{type}=" do |array|
            klass = "FatSecret::#{type.to_s.singularize.classify}".constantize
            servings = array[type.to_s.singularize].map do |attrs|
              klass.new(attrs)
            end
            @servings = HasManyProxy.new(servings)
          end
        end
      end
    end
  end
end

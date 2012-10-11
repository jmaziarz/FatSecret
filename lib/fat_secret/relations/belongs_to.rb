module FatSecret
  module Relations
    module BelongsTo
      extend ActiveSupport::Concern

      module ClassMethods
        def belongs_to(type, options = {})

          class_eval do
            attribute "#{type}_id", type: Integer

            attr_reader type
          end

          define_method "#{type}=" do |arg|
            instance_variable_set(:"@#{type}", arg)
            arg.send("#{self.class.name.split('::').last.downcase.pluralize}") << self
          end
        end
      end
    end
  end
end

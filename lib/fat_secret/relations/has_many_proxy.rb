module FatSecret
  module Relations
    class HasManyProxy < BasicObject

      attr_reader :target

      def initialize(target)
        @target = target
      end

      protected

      def method_missing(name, *args, &block)
        target.send(name, *args, &block)
      end

      def target
        @target || []
      end
    end
  end
end

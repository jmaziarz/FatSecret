module FatSecret
  class ResultsProxy < BasicObject

    attr_reader :max_results, :page_number, :total_results

    def initialize(target, max_results, page_number, total_results )
      @max_results = max_results.try(:to_i)
      @page_number = page_number.try(:to_i)
      @total_results = total_results.try(:to_i)
      @target = target
    end

    def load_associations
      raise NotImplementedError
    end

    protected

    def method_missing(name, *args, &block)
      target.send(name, *args, &block)
    end

    def target
      @target ||= []
    end
  end
end

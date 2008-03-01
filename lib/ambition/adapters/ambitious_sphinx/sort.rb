module Ambition::Adapters::AmbitiousSphinx
  # +Sort+ would normally handle sorting, but we don't support it yet.
  class Sort < Base
    # Not implemented
    def sort_by(method)
      raise "Not implemented."
    end

    # Not implemented
    def reverse_sort_by(method)
      raise "Not implemented."
    end

    # Not implemented
    def chained_sort_by(receiver, method)
      raise "Not implemented."
    end

    # Not implemented
    def chained_reverse_sort_by(receiver, method)
      raise "Not implemented."
    end

    # Not implemented
    def to_proc(symbol)
      raise "Not implemented."
    end

    # Not implemented
    def rand
      raise "Not implemented."
    end
  end
end

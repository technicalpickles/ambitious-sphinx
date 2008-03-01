module Ambition::Adapters::AmbitiousSphinx
  # Slice would normally handle slicing, but we don't support it yet.
  class Slice < Base
    # Not implemented
    def slice(start, length)
      raise "Not implemented."
    end
  end
end

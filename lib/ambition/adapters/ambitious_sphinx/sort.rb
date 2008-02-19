module Ambition #:nodoc:
  module Adapters #:nodoc:
    module AmbitiousSphinx #:nodoc:
      # Allows you to sort queries by particular fields.
      # It is unsure how well this is supported by Ultrasphinx.
      class Sort < Base
        # Not implemented yet.
        def sort_by(method)
          raise "Not implemented yet."
        end

        # Not implemented yet.
        def reverse_sort_by(method)
          raise "Not implemented yet."
        end

        # Not implemented yet.
        def chained_sort_by(receiver, method)
          raise "Not implemented yet."
        end

        # Not implemented yet.
        def chained_reverse_sort_by(receiver, method)
          raise "Not implemented yet."
        end

        # Not implemented yet.
        def to_proc(symbol)
          raise "Not implemented yet."
        end

        # Not implemented yet.
        def rand
          raise "Not implemented yet."
        end
      end
    end
  end
end

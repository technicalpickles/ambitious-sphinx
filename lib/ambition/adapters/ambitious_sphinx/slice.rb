module Ambition #:nodoc:
  module Adapters #:nodoc:
    module AmbitiousSphinx
      class Slice < Base
        # >> User.first(5)
        # => #slice(0, 5)
        #
        # >> User.first
        # => #slice(0, 1)
        #
        # >> User[10, 20]
        # => #slice(10, 20)
        def slice(start, length)
          raise "Not implemented."
        end
      end
    end
  end
end

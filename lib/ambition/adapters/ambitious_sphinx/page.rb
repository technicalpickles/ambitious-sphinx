module Ambition #:nodoc:
  module Adapters #:nodoc:
    module AmbitiousSphinx
      class Page < Base
        def page(number)
          raise "Must be greater than 0" unless number > 0
          number
        end
      end
    end
  end
end

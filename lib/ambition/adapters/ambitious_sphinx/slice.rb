module Ambition #:nodoc:
  module Adapters #:nodoc:
    module AmbitiousSphinx #:nodoc:
      # Slicing would normally let you choose a 'slice' of the search results.
      #
      # We don't support it at this time because of limitations of Ultrasphinx.
      # It allows you to select what 'page' of results to select, but not a specific range.
      class Slice < Base
        
        # Not implemented.
        def slice(start, length)
          raise "Not supported by Ultrasphinx"
        end
      end
    end
  end
end

module Ambition
  module Adapters
    module AmbitiousSphinx
      class Base
        def field? str
          str =~ /:/
        end
        
        def has_operator? str
          str =~ /(AND|OR|NOT)/
        end
        
        def quotify str
          unless field?(str) or has_operator?(str)
            "\"#{str}\""
          else
            str
          end
        end
      end
    end
  end
end
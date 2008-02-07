module Ambition
  module Adapters
    module AmbitiousSphinx
      class Base
        def field? str
          str =~ /:/
        end
        
        def quotify str
          unless field? str
            "\"#{str}\""
          else
            str
          end
        end
      end
    end
  end
end
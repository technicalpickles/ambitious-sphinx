module Ambition
  module Adapters
    module AmbitiousSphinx
      class Base
        def has_field? str
          str =~ /:/
        end
        
        def has_operator? str
          str =~ /(AND|OR|NOT)/
        end
        
        def needs_quoting? str
          not (has_operator?(str) or has_field?(str))
        end
        
        def quotify str
          if needs_quoting?(str)
            %Q("#{str}")
          else
            str
          end
        end
      end
    end
  end
end
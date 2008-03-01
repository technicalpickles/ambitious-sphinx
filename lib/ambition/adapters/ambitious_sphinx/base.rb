module Ambition
  module Adapters
    module AmbitiousSphinx
      # Helper for the other
      class Base
        # Does the string have an Ultrasphinx field?
        def has_field? str
          str =~ /:/
        end
    
        # Does the string have any Ultrasphinx operators?
        def has_operator? str
          str =~ /(AND|OR|NOT)/
        end
    
        # Should this string be quotified? It needs to happen if the string doesn't
        # have an operator or a field.
        def needs_quoting? str
          not (has_operator?(str) or has_field?(str))
        end
    
        # Quote the string if it needs it.
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
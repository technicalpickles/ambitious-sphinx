module Ambition #:nodoc:
  module Adapters #:nodoc:
    module AmbitiousSphinx #:nodoc:
      class Base
        # Does the string contain a field (in terms of Ultrasphinx's querying).
        # This is basically checking for a colon. Typically, you'd see something like:
        #
        #   name:"some search terms"
        def has_field? str
          str =~ /:/
        end
        
        # Does the string contain a query operator? This includes AND, OR, and NOT.
        def has_operator? str
          str =~ /(AND|OR|NOT)/
        end
        
        # Does the string need to be quoted? It needs to be quoted unless it doesn't
        # have an operator or field.
        def needs_quoting? str
          not (has_operator?(str) or has_field?(str))
        end
        
        # Add quotes to the string if it needs it.
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
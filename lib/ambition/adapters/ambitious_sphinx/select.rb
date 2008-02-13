module Ambition
  module Adapters
    module AmbitiousSphinx
      # Select is responsible for taking pure Ruby, and mangling it until it resembles
      # the syntax that UltraSphinx[http://blog.evanweaver.com/files/doc/fauna/ultrasphinx/files/README.html] uses.
      class Select < Base
        # method calls
        # converts
        def call(method)
          "#{method.to_s}:"
        end

        # chained calls not supported
        def chained_call(*methods)
          # An idiom here is to call the chained method and pass it
          # the first method.
          #
          #   if respond_to? methods[1]
          #     send(methods[1], methods[0])
          #   end
          #
          # In the above example, this translates to calling:
          #
          #   #downcase(:name)
          #
          raise "Not implemented yet."
        end

        # Handles generating an UltraSphinx query for code like:
        #
        #   'foo' && 'bar'
        def both(left, right)
          "#{quotify left} AND #{quotify right}"
        end

        # Handles generating an UltraSphinx query for code like:
        #
        #   'foo' || 'bar'
        def either(left, right)
          "#{quotify left} OR #{quotify right}"
        end

        # Sphinx doesn't support equality.
        def ==(left, right)
          raise "Not applicable to sphinx."
        end

        # Sphinx doesn't support inequality.
        def not_equal(left, right)
          raise "Not applicable to sphinx."
        end

        # >> select { |u| u.name =~ 'chris' }
        # => #=~( call(:name), 'chris' )
        def =~(left, right)
          raise if right.is_a? Regexp
          "#{left}#{quotify right}"
        end

        # !~
        # >> select { |u| u.name !~ 'chris' }
        # => #not_regexp( call(:name), 'chris' )
        def not_regexp(left, right)
          # could be DRYer, but this is more readable than: "NOT #{self.=~(left,right)}"
          raise if right.is_a? Regexp
          "NOT #{left}#{quotify right}"
        end

        ##
        # Etc.
        def <(left, right)
          raise "Not applicable to sphinx."
        end

        def >(left, right)
          raise "Not applicable to sphinx."
        end

        def >=(left, right)
          raise "Not applicable to sphinx."
        end

        def <=(left, right)
          raise "Not applicable to sphinx."
        end

        # >> select { |u| [1, 2, 3].include? u.id }
        # => #include?( [1, 2, 3], call(:id) )
        def include?(left, right)
          raise "Not applicable to sphinx."
        end
      end
    end
  end
end

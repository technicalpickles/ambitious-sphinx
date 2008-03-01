module Ambition
  module Adapters
    module AmbitiousSphinx
      # Select is responsible for taking pure Ruby, and mangling it until it resembles
      # the syntax that Ultrasphinx[http://blog.evanweaver.com/files/doc/fauna/ultrasphinx/files/README.html] uses.
      class Select < Base
        # Handles method calls, like
        #
        #   u.name
        def call(method)
          "#{method.to_s}:"
        end

        # Should we be supporting chained calls like:
        #
        #   u.name.downcase
        #
        # ?
        # 
        # I don't think Sphinx would be able to handle this.
        def chained_call(*methods)
          raise "Not implemented yet."
        end

        # Handles generating an Ultrasphinx query for code like:
        #
        #   'foo' && 'bar'
        def both(left, right)
          "#{quotify left} AND #{quotify right}"
        end

        # Handles generating an Ultrasphinx query for code like:
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

        # Handles generating an Ultrasphinx query for code like:
        #
        #   u.name =~ 'bob'
        #
        # Some cavaets:
        #  * left hand side _must_ be a field, like u.name
        #  * right hand side _must not_ be a regular expression. Pattern matching is generally not
        #    supported by full text search engines
        def =~(left, right)
          raise if right.is_a? Regexp
          "#{left}#{quotify right}"
        end

        # Handles generating an Ultrasphinx query for code like:
        #
        #   u.name !~ 'bob'
        #
        # Some cavaets:
        #  * left hand side _must_ be a field, like u.name
        #  * right hand side _must not_ be a regular expression. Pattern matching is generally not
        #    supported by full text search engines
        def not_regexp(left, right)
          # could be DRYer, but this is more readable than: "NOT #{self.=~(left,right)}"
          raise if right.is_a? Regexp
          "NOT #{left}#{quotify right}"
        end

        # Not supported by Sphinx. If you need this kind of comparison, you probably should be
        # using ambitious-activerecord.
        def <(left, right)
          raise "Not applicable to sphinx."
        end

        # Not supported by Sphinx. If you need this kind of comparison, you probably should be
        # using ambitious-activerecord.
        def >(left, right)
          raise "Not applicable to sphinx."
        end

        # Not supported by Sphinx. If you need this kind of comparison, you probably should be
        # using ambitious-activerecord.
        def >=(left, right)
          raise "Not applicable to sphinx."
        end

        # Not supported by Sphinx. If you need this kind of comparison, you probably should be
        # using ambitious-activerecord.
        def <=(left, right)
          raise "Not applicable to sphinx."
        end

        # Not supported by Sphinx. If you need this kind of comparison, you probably should be
        # using ambitious-activerecord.
        def include?(left, right)
          raise "Not applicable to sphinx."
        end
      end
    end
  end
end

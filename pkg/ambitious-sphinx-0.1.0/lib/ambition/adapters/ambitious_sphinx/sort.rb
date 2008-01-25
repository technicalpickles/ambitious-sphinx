module Ambition
  module Adapters
    module AmbitiousSphinx
      class Sort < Base
        # >> sort_by { |u| u.age }
        # => #sort_by(:age)
        def sort_by(method)
          raise "Not implemented."
        end

        # >> sort_by { |u| -u.age }
        # => #reverse_sort_by(:age)
        def reverse_sort_by(method)
          raise "Not implemented."
        end

        # >> sort_by { |u| u.profile.name }
        # => #chained_sort_by(:profile, :name)
        def chained_sort_by(receiver, method)
          raise "Not implemented."
        end

        # >> sort_by { |u| -u.profile.name }
        # => #chained_reverse_sort_by(:profile, :name)
        def chained_reverse_sort_by(receiver, method)
          raise "Not implemented."
        end

        # >> sort_by(&:name)
        # => #to_proc(:name)
        def to_proc(symbol)
          raise "Not implemented."
        end

        # >> sort_by { rand }
        # => #rand
        def rand
          raise "Not implemented."
        end
      end
    end
  end
end

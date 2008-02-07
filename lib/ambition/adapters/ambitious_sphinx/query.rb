=begin

These methods are king:

  - owner
  - clauses
  - stash

+owner+ is the class from which the request was generated.

User.select { |u| u.name == 'Pork' }
# => owner == User

+clauses+ is the hash of translated arrays, keyed by processors

User.select { |u| u.name == 'Pork' }
# => clauses ==  { :select => [ "users.name = 'Pork'" ] }

+stash+ is your personal private stash.  A hash you can use for
keeping stuff around.

User.select { |u| u.profile.name == 'Pork' }
# => stash == { :include => [ :profile ] }

The above is totally arbitrary.  It's basically a way for your
translators to talk to each other and, more importantly, to the Query
object.

=end
module Ambition
  module Adapters
    module AmbitiousSphinx
      class Query < Base
        def kick
          Ultrasphinx::Search.new(to_hash).results
        end

        def size
          raise "Example: owner.count(to_hash)"
        end

        def to_hash
          hash = {}

          unless (query = clauses[:select]).blank?
            query_s = query.join(' ').squeeze(' ').strip 
            hash[:query] = quotify(query_s)
          end
          
          hash
        end

        def to_s
          hash = to_hash
          hash[:query]
        end
      end
    end
  end
end

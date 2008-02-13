module Ambition
  module Adapters
    module AmbitiousSphinx
      # Responsible for taking the clauses that Ambition has generated, and ultimately doing a
      # Ultrasphinx::Search based on them
      class Query < Base
        def kick
          Ultrasphinx::Search.new(to_hash).results
        end

        # Not entirely sure what this is for, so unimplemented so far.
        def size
          raise "Not implemented yet."
        end

        # Builds a hash of options for Ultrasphinx::Search based on the clauses Ambition has generated.
        def to_hash
          hash = {}

          unless (query = clauses[:select]).blank?
            query_s = query.join(' ').squeeze(' ').strip 
            hash[:query] = quotify(query_s)
          end
          
          hash
        end

        # Prints out the query that would be executed.
        def to_s
          hash = to_hash
          hash[:query]
        end
      end
    end
  end
end

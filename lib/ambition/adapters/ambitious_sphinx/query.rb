module Ambition::Adapters::AmbitiousSphinx
  # Responsible for taking the clauses that Ambition has generated, and ultimately doing a
  # Ultrasphinx::Search based on them
  class Query < Base
    def kick
      Ultrasphinx::Search.new(to_hash).results
    end

    # Some magic to add pagination. This gets called if you were to do:
    #
    #   Meal.select {'bacon'}.page(5)
    #
    # When +page+ is invoked, it's actually being invoked on +Ambition::Context+.
    # It has +method_missing+? voodoo which will try to pass the method onto
    # the +Query+. That's this class.
    def page(number)
      stash[:page] = number
      context
    end

    # Not entirely sure when this is used, so unimplemented so far.
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
      
      unless (page = stash[:page]).blank?
        hash[:page] = page
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

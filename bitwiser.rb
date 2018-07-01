require_relative 'core/bit_sequence.rb'
require_relative 'core/signed_sequence.rb'

module Bitwiser
  class Signed4 < SignedSequence
    def initialize(value, size=4)
      super(value, size)
    end
  end

  class Unsigned4 < BitSequence::Base
    def initialize(value, size=4)
      super(value, size)
    end
  end

  class Signed8 < SignedSequence
    def initialize(value, size=8)
      super(value, size)
    end
  end

  class Unsigned8 < BitSequence::Base
    def initialize(value, size=8)
      super(value, size)
    end
  end
end

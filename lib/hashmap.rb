# frozen_string_literal: true

# Hashmap Implementation
class HashMap
  def initialize(capacity = 16, load_factor = 0.875)
    @capacity = capacity
    @load_factor = load_factor
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end
end

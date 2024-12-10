# frozen_string_literal: true

# Hashmap Implementation
class HashMap
  def initialize(capacity = 16, load_factor = 0.875)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(capacity) { [] }
    @entries = 0
  end

  def set(key, value)
    bucket_number = hash(key) % @capacity
    if (index = @buckets[bucket_number].find_index { |entry| entry[0] == key })
      @buckets[bucket_number][index][1] = value
    else
      @buckets[bucket_number] << [key, value]
    end
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end
end

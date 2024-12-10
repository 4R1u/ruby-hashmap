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
      grow_buckets if (@entries += 1) > @capacity * @load_factor
      @buckets[bucket_number] << [key, value]
    end
  end

  def has?(key)
    @buckets[hash(key) % @capacity].any? { |entry| entry[0] == key }
  end

  def remove(key)
    bucket_number = hash(key) % @capacity
    index = @buckets[bucket_number].find_index { |entry| entry[0] == key }
    return unless index

    @buckets[bucket_number].delete_at(index)[1]
  end

  private

  def grow_buckets
    entries = []
    @buckets.each { |bucket| bucket.each { |entry| entries << entry } }
    @buckets = Array.new(@capacity += 1) { [] }
    entries.each { |entry| @buckets[hash(entry[0]) % @capacity] << entry }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end
end

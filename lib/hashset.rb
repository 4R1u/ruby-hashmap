# frozen_string_literal: true

# Set Implementation, Like a Hashmap But with no Values
class HashSet
  attr_reader :length

  def initialize(capacity = 16, load_factor = 0.875)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(capacity) { [] }
    @length = 0
  end

  def set(key)
    bucket_number = hash(key) % @capacity
    return key if @buckets[bucket_number].find_index(key)

    @buckets[bucket_number] << key
  end

  def get(key)
    @buckets[hash(key) % @capacity].find { |entry| entry[0] == key }
  end

  def has?(key)
    @buckets[hash(key) % @capacity].any? { |entry| entry[0] == key }
  end

  def remove(key)
    bucket_number = hash(key) % @capacity
    index = @buckets[bucket_number].find_index { |entry| entry[0] == key }
    return unless index

    @length -= 1
    @buckets[bucket_number].delete_at(index)[1]
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @length = 0
  end

  def keys
    keys = []
    @buckets.each { |bucket| bucket.each { |entry| keys << entry[0] } }
    keys
  end

  def values
    values = []
    @buckets.each { |bucket| bucket.each { |entry| values << entry[1] } }
    values
  end

  def entries
    entries = []
    @buckets.each { |bucket| bucket.each { |entry| entries << entry } }
    entries
  end

  private

  def grow_buckets
    entries = []
    @buckets.each { |bucket| bucket.each { |entry| entries << entry } }
    @buckets = Array.new(@capacity *= 2) { [] }
    entries.each { |entry| @buckets[hash(entry[0]) % @capacity] << entry }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

    hash_code
  end
end

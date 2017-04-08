require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      @count += 1
      resize! if @count > num_buckets
      self[key.hash] << key
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key) if include?(key)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets * 2
    new_buckets = Array.new(new_size){Array.new}
    @store.each do |bucket|
      bucket.each do |key|
        new_buckets[key.hash % new_size] = key
      end
    end
    @store = new_buckets
  end
end

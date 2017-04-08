class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max+1) {false}
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    buck_num = num % num_buckets
    @store[buck_num] << num
  end

  def remove(num)
    buck_num = num % num_buckets
    @store[buck_num].delete(num)
  end

  def include?(num)
    buck_num = num % num_buckets
    @store[buck_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    @count += 1
    resize! if @count > num_buckets
    buck_num = num % num_buckets
    @store[buck_num] << num
  end

  def remove(num)
    buck_num = num % num_buckets
    @store[buck_num].delete(num)
  end

  def include?(num)
    buck_num = num % num_buckets
    @store[buck_num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = Array.new(num_buckets * 2){Array.new}
    new_buckets_count = new_buckets.length
    @store.each do |bucket|
      bucket.each do |num|
        buck_num = num % new_buckets_count
        new_buckets[buck_num] << num
      end
    end
    @store = new_buckets
  end
end

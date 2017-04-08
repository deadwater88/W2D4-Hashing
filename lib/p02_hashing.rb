class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 0
    self.each_with_index do |el, idx|
      hash_value += (el.hash + idx.hash).hash
    end

    hash_value
  end
end

class String
  def hash
    self.chars.map { |char| char.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end

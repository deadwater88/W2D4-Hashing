require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev = @prev
    @prev.next = @next
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Link.new
    @tail = Link.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }

  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node_to_check = @head
    loop do
      if node_to_check.key == key
        return node_to_check.val
      elsif node_to_check.next == @tail
        return nil
      else
        node_to_check = node_to_check.next
      end
    end
  end

  def include?(key)
    node_to_check = @head
    loop do
      if node_to_check.key == key
        return true
      elsif node_to_check.next == @tail
        return false
      else
        node_to_check = node_to_check.next
      end
    end
  end

  def append(key, val)
    temp_last = last
    link_to_add = Link.new(key, val)
    temp_last.next = link_to_add
    link_to_add.prev = temp_last
    link_to_add.next = @tail
    @tail.prev = link_to_add
  end

  def update(key, val)
    node_to_check = @head
    loop do
      if node_to_check.key == key
        node_to_check.val = val
        return "updated"
      elsif node_to_check.next == @tail
        return false
      else
        node_to_check = node_to_check.next
      end
    end
  end

  def remove(key)
    node_to_check = @head
    loop do
      if node_to_check.key == key
        node_to_check.remove
        return
      elsif node_to_check.next == @tail
        return false
      else
        node_to_check = node_to_check.next
      end
    end
  end

  def each(&prc)
    node_to_add = @head.next
    until node_to_add == @tail
      prc.call(node_to_add)
      node_to_add = node_to_add.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end

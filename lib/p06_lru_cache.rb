require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'
class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      update_link!(@map[key])
      @map[key].val
    else
      eject! if count == @max
      val = @prc.call(key)
      calc!(key, val)
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key, val)
    @store.append(key, val)
    @map[key] = @store.last
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @store.append(link.key, link.val)
    @map[link.key] = @store.last
    link.remove
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end

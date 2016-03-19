require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :prc, :max
  attr_accessor :map, :store
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
    if @map.get(key).nil?
      new_value = calc!(key)
      update_link!(Link.new(key,new_value))
      return new_value
    else
      @store.get(key)
      new_tail = @store.get_link(key)
      @store.remove(key)
      update_link!(new_tail)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    prc.call(key)
  end

  def update_link!(link)
    @store.insert(link.key, link.val)
    if count + 1 > max
      @map.delete(eject!)
    end
    @map.set(link.key, link.val)
  end

  def eject!
    removed_key = @store.head.key
    @store.remove(@store.head.key)
    removed_key
  end
end

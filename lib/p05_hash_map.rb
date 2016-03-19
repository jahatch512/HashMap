require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap

  include Enumerable
  attr_accessor :count
  attr_accessor :store


  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    store[key.hash%num_buckets].include?(key)
  end

  def set(key, val)
    @count += 1
    resize! if count > store.size
    changed = false
    store[key.hash%num_buckets].each do |link|
      if link.key == key
        link.val = val
        changed = true
      end
    end
    store[key.hash%num_buckets].insert(key,val) unless changed
  end

  def get(key)
    linked_list = store[key.hash%num_buckets]
    linked_list.get(key)
  end

  def delete(key)
    linked_list = store[key.hash%num_buckets]
    linked_list.remove(key)
    @count -= 1
  end

  def each(&prc)
    store.each do |linked_list|
      linked_list.each do |link|
        prc.call(link.key,link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times do
      store << LinkedList.new
    end
    temporary_links = []
    store.each do |linked_list|
      linked_list.each do |link|
        k,v = link.key, link.val
        temporary_links << [k,v]
        linked_list.remove(link.key)
      end
    end
    temporary_links.each do |k,v|
      store[k.hash%num_buckets].insert(k, v)
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

# h = HashMap.new
# h.set("a", 1)
# h.set("b", 2)
# h.set("c", 3)
# h.set("d", 4)
# h.set("e", 5)
# h.set("f", 6)
# h.set("g", 7)
# h.set("h", 8)
# h.set("i", 9)
# h.set("j", 10)
# h.set("k", 11)
# h.set("l", 12)

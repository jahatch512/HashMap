require_relative 'p02_hashing'

class HashSet
  attr_accessor :count
  attr_accessor :num_buckets
  attr_accessor :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    if count > store.size
      resize!
      store[key.hash%store.size] << key
    else
      store[key.hash%store.size] << key
    end
  end

  def include?(key)
    store[key.hash%store.size].include?(key)
  end

  def remove(key)
    store[key.hash%store.size].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    store.size.times do
      store << []
    end
    store.each do |bucket|
      bucket.each do |num|
        bucket.delete(num)
        store[num%store.size] << num
      end
    end
  end
end

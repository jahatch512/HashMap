
class MaxIntSet

  attr_accessor :store

  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(item)
    raise "Out of bounds" unless item.between?(0,store.size-1)
    store[item] = true
  end

  def remove(item)
    store[item] = false
  end

  def include?(item)
    store[item]
  end
end

class IntSet
  attr_accessor :store
  attr_reader :size
  def initialize(size)
    @store = Array.new(size) {[]}
    @size = size
  end

  def insert(num)
    store[num%size] << num unless include?(num)
  end

  def remove(item)
    store[item%size].delete(item)
  end

  def include?(num)
    store[num%size].include?(num)
  end
end


class ResizingIntSet
  attr_accessor :count
  attr_accessor :num_buckets
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0


  end

  def insert(num)
    @count += 1
    if count > store.size
      resize!
      store[num%store.size] << num
    else
      store[num%store.size] << num
    end

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

  def remove(num)
    store[num%store.size].delete(num)
  end

  def include?(num)
    store[num%store.size].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

end

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
end

class LinkedList
  include Enumerable

  private
  attr_reader :h_sentinel, :t_sentinel
  public

  attr_accessor :head, :tail

  def initialize
    @h_sentinel = Link.new
    @t_sentinel = Link.new
    t_sentinel.prev = h_sentinel
    h_sentinel.next = t_sentinel
    @head = nil
    @tail = nil
    @count = 0
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    h_sentinel.next == t_sentinel ? nil : h_sentinel.next
  end

  def last
    t_sentinel.prev == h_sentinel ? nil : t_sentinel.prev
  end

  def empty?
    h_sentinel.next == t_sentinel
  end

  def get(key)
    current_link = h_sentinel
    until current_link.next == nil
      current_link = current_link.next
      return current_link.val if current_link.key == key
    end
    return nil
  end

  def get_link(key)
    current_link = h_sentinel
    until current_link.next == nil
      current_link = current_link.next
      return current_link if current_link.key == key
    end
    return nil
  end

  def include?(key)
    get(key) ? true : false
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    current_last = t_sentinel.prev
    current_last.next = new_link
    new_link.prev = current_last
    t_sentinel.prev = new_link
    new_link.next = t_sentinel
    @tail = last
    @head = first
  end

  def remove(key)
    removal_link = get_link(key)
    new_next = removal_link.next
    new_prev = removal_link.prev
    new_prev.next = new_next
    new_next.prev = new_prev
    @tail = last
    @head = first
  end

  def each(&prc)
    current_link = h_sentinel.next
    until current_link == t_sentinel
        prc.call(current_link)
        current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

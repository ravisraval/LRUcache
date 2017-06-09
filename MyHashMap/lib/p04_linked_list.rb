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
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next.prev = @prev unless @next == nil
    @prev.next = @next unless @prev == nil
    #self = nil

  end
end

class LinkedList
  include Enumerable

  def initialize
    @links = []
  end

  def [](i)
    @links.each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @links.first
  end

  def last
    @links.last
  end

  def empty?
    @links.empty?
  end

  def get(key)
    @links.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    return true if get(key)
    false
  end

  def append(key, val)
    if empty?
      @links << Link.new(key, val)
    else
      new_link = Link.new(key, val)
      self.last.next = new_link
      new_link.prev = last
      @links << new_link
    end
  end

  def update(key, val)
    @links.each do |link|
      link.val = val if link.key == key
    end
  end

  def remove(key)
    @links.each do |link|
      if link.key == key
        link.remove
        @links.delete(link)
      end
    end

  end

  def each
    @links.each do |link|
      proc.call(link)
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end

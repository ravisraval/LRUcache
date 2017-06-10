class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity) {nil}
    @count = 0
  end

  def [](i)
    until i >= capacity
      resize!
    end
    if i > -1
      @store[i]
    else
      @store[length + i]
    end
  end

  def []=(i, val)
    until i >= capacity
      resize!
    end
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    @count += 1
    resize! if @count > capacity
    @store[count - 1] = val
  end

  def unshift(val)
    @count += 1
    resize! if @count > capacity
    i = @count
    while i > 0
      @store[i] = @store[i - 1]
      i -= 1
    end
    @store[0] = val
    @store
  end

  def pop
    @store[count - 1] = nil
    @count -= 1
  end

  def shift
    i = 0
    while i < @count
      @store[i] = @store[i + 1]
      i += 1
    end
    pop
  end

  def first
    @store[0]
  end

  def last
    @store[count - 1]
  end

  def each
    i = 0
    while i < count
      yield(@store[i])
      i += 1
    end
    @store
  end

  def each_with_index
    i = 0
    while i < count
      yield(@store[i], i)
      i += 1
    end
    @store
  end

  def self
    to_s
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    each_with_index do |el, i|
      new_store[i] = el
    end
    @store = new_store
  end
end

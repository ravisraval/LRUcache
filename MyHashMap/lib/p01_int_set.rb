class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max + 1, false)
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' unless num.between?(0, @max)
    true
  end

  # def validate!(num)
  # end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length].push(num)
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
      @store[num % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    @store[num % num_buckets].push(num)
    @count += 1

    if @count == num_buckets
      resize!
    end
  end

  def remove(num)
    return unless include?(num)
    @store[num % num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
      @store[num % num_buckets].include?(num)
  end


  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num % (num_buckets * 2)].push(num)
      end
    end
    @store = new_store
  end
end

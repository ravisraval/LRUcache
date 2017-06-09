require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    p key
    num = key.hash
    p num
    self[num].push(key) unless include?(key)
    @count += 1
    resize! if @count == num_buckets
  end

  def include?(key)
    num = key.hash
    puts "num"
    p num
    puts "key"
    p key
    puts "store"
    p @store
    self[num].include?(key)
  end

  def remove(key)
    return unless include?(key)
    num = key.hash
    self[num].delete(key)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {[]}
    @store.each do |bucket|
      bucket.each do |key|
        new_store[key.hash % (num_buckets * 2)] = key
      end
    end
    @store = new_store
  end
end

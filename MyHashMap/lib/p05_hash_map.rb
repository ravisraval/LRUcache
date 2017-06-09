require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].include?(key)
  end

  def set(key, val)
    num = key.hash

    if include?(key)
      @store[num % num_buckets].update(key, val)
    else
      @store[num % num_buckets].append(key, val)
      @count += 1
    end
    resize! if @count == num_buckets

  end

  def get(key)
    num = key.hash
    @store[num % num_buckets].get(key)
  end

  def delete(key)
    return unless include?(key)
    num = key.hash
    @store[num % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |linkedlist|
      linkedlist.each do |link|
        yield(link.key, link.val)
      end
    end

  end
  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |linkedlist|
      linkedlist.each do |link|
        num = link.key.hash
          new_store[num % (num_buckets * 2)].append(link.key, link.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

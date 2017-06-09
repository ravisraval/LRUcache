require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
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
    if @map.include?(key)
      current_link = @map[key]
      update_link!(current_link) #makes link most recent
      current_link.val #returns value prc.call(key)
    else #not in cache
      new_val = calc!(key)
      @store.append(key, new_val)
      @map[key] = @store.last

      eject! if count > @max
      new_val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    key_to_eject = @store.first.key
    @store.remove(key_to_eject)
    @map.delete(key_to_eject)
  end
end

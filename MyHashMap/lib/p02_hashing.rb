class Fixnum
  # Fixnum#hash already implemented for you
end

# class Array
#   def hash
#     result = {}
#     self.each_with_index do |el, idx|
#       result[idx] = el.ord.hash
#     end
#     result
#   end
# end

class Array
  def hash #[1,2,4]
    each_with_index.inject(0) do |intermediate_hash, (el, i)|
      (el.hash + i.hash) ^ intermediate_hash
    end
  end
end


class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end

=begin
[1,2]

0 1
1 2

=end

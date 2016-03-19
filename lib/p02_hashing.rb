require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    og_hash = self[0].hash ^ 0.hash
    each_with_index do |el,idx|
      og_hash = og_hash ^ (el.hash ^ idx.hash)
    end
    og_hash
  end
end

class String
  def hash
   return ord.hash if size == 1
   og_hash = chars[0].ord.hash ^ 0.hash
   chars.each_with_index do |char,idx|
     og_hash = og_hash ^ (char.ord.hash ^ idx.hash)
   end
   og_hash
  end
end

class Hash
  def hash
    zipper = keys.zip(values)
    og_hash = 1.hash
    zipper.each_with_index do |(x,y),i|
      og_hash = og_hash ^ (x.hash ^ y.hash)
    end
    og_hash
  end
end

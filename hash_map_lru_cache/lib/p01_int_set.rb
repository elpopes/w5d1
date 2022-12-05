class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max,false)
  end
  attr_reader :max, :store
require "byebug"
  def insert(num)
    if is_valid?(num) 
        @store[num] = true 
    else
        raise "Out of bounds"
    end
    # debugger
    @store[num]
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private


  def is_valid?(num)
    num > 0 && num < max
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].select! {|spot| spot != num}
  end

  def include?(num)
     self[num].include?(num)   
  end

  private

  def [](num)
    @store[num % num_buckets] 
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
        self[num] << num 
        @count += 1
        if count == @num_buckets
            resize!
        end
    end
  end

  def remove(num)
    if include?(num)
        self[num].select! {|spot| spot != num}
        @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)   
  end

  private

  def [](num)
    @store[num % num_buckets] 
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = []
    @store.each do |bucket|
        bucket.each do |num|
            remove(num)
            old_store << num
        end
    end
    @num_buckets *= 2
    until @store.size == @num_buckets
        @store << []
    end
    old_store.each do |num| 
        insert(num)
     end
  end
end

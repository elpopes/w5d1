class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    key = key.hash
    unless include?(key)
        self[key] << key 
        @count += 1
        if count == @num_buckets
            resize!
        end
    end
  end

  def include?(key)
    key = key.hash
    self[key].include?(key)   
  end

  def remove(key)
    # key = key.hash
    if include?(key)
        self[key].select! {|spot| spot != key.hash}
        @count -= 1
    end 
  end

  private

  def [](key)
    @store[key.hash % num_buckets] 
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = []
    @store.each do |bucket|
        bucket.each do |key|
            remove(key)
            old_store << key
        end
    end
    @num_buckets *= 2
    until @store.size == @num_buckets
        @store << []
    end
    old_store.each do |key| 
        insert(key)
     end
  end
end

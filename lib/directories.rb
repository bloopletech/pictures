class Directories
  include Singleton

  def initialize
    @mutex = Mutex.new
    @cache = {}
  end

  def fetch(path)
    @mutex.synchronize {
      key = path.to_s
      if @cache.key?(key)
        @cache[key][:directory]
      else
        if @cache.keys.length > 5
          oldest = nil
          @cache.each_pair { |k, v| oldest = k if oldest.nil? || v[:added] < @cache[oldest][:added] }
          puts "oldest is: #{oldest.inspect}"
          @cache.delete(oldest)
        end
        puts "storing, cache: #{@cache.inspect}"

        dir = Directory.new(path)
        dir.load
        @cache[key] = { :directory => dir, :added => Time.now }
        dir
      end
    }
  end
end


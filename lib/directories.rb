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
        @cache[key]
      else
        if @cache.keys.length > 50
          @cache.delete(@cache.keys.first)
        end

        dir = Directory.new(path)
        dir.load
        @cache[key] = dir
      end
    }
  end
end


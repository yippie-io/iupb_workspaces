class LockedSpawner
  def self.crawl
    if defined?(::REDIS) && ::REDIS.get("crawling") == "1"
      return false
    else
      Spawner.spawn do
        redis = Redis.new(::REDIS_URL) if defined?(::REDIS)
        redis.set "crawling", "1" if defined?(redis)
        ### run crawler
        redis.set "crawling", "0" if defined?(redis)
      end
      return true
    end
  end
end
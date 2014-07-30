require './app/relations/concerns/relation_logic'

class BlogRelation < RelationLogic

  def self.to_added_users(blog_id)
    self.redis.smembers("blog:#{blog_id}:added_users")
  end

  def self.to_like_count(blog_id)
  	self.redis.scard("blog:#{blog_id}:user_likes")
  end

  # def self.add_blog_feed(blog)
  #   self.redis.sadd("user:#{blog.user_id}:blog_feed", )
  # end

  # def self.get_blog_feed(user_id)
  #   self.redis.smembers("user:#{user_id}:blog_feed").map(&:to_i)
  # end

end
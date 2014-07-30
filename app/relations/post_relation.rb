require './app/relations/concerns/relation_logic'

class PostRelation < RelationLogic

  def self.add_post(post)
    self.redis.zadd("user:#{post.user_id}:posts", post.created_at.to_i, post.id)
  end

  def self.to_like_count(post_id)
  	self.redis.scard("post:#{post_id}:user_likes")
  end

end
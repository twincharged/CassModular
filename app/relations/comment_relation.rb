require './app/relations/concerns/relation_logic'

class CommentRelation < RelationLogic

  def self.add_comment(comment)
    self.redis.zadd("user:#{comment.user_id}:comments", comment.created_at.to_i, comment.id)
  end

  def self.get_like_count(comment_id)
  	self.redis.scard("comment:#{comment_id}:user_likes")
  end
end
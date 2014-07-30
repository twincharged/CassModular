require './app/relations/concerns/relation_logic'

class UserRelation < RelationLogic

##### Post/blog

  def self.to_posts(user_id, range)
    self.redis.zrevrange("user:#{user_id}:posts", 0, range).map(&:to_i)
  end


  def self.to_blogs(user_id, range)
    self.redis.zrevrange("user:#{user_id}:blogs", 0, range).map(&:to_i)
  end

##### Following

  def self.to_followers(user_id)
    self.redis.smembers("user:#{user_id}:followers").map(&:to_i)
  end


  def self.to_following(user_id)
    self.redis.smembers("user:#{user_id}:following").map(&:to_i)
  end
  

  def self.add_follow(follower_id, followee_id)
  	self.redis.sadd("user:#{followee_id}:followers", follower_id)
  	self.redis.sadd("user:#{follower_id}:following", followee_id)
  end


  def self.remove_follow(follower_id, followee_id)
    self.redis.srem("user:#{followee_id}:followers", follower_id)
    self.redis.srem("user:#{follower_id}:following", followee_id)
  end

  def self.check_following(follower_id, followee_id)
    self.redis.sismember("user:#{followee_id}:followers", follower_id)
  end

  def self.check_follower(follower_id, followee_id)
    self.redis.sismember("user:#{followee_id}:following", follower_id)
  end

##### Blocks

  def self.add_block(blocker_id, blockee_id)
    self.redis.sadd("user:#{blocker_id}:blocked_users", blockee_id)
  end


  def self.to_blocked_users(blocker_id)
    self.redis.smembers("user:#{blocker_id}:blocked_users")
  end


  def self.remove_block(blocker_id, blockee_id)
    self.redis.srem("user:#{blocker_id}:blocked_users", blockee_id)
  end

##### blogs

  def self.add_blog_user(user_id, blog_id)
    self.redis.sadd("user:#{user_id}:added_blogs", blog_id)
    self.redis.sadd("blog:#{blog_id}:added_users", user_id)
  end

  def self.remove_blog_user(user_id, blog_id)
    self.redis.srem("user:#{user_id}:added_blogs", blog_id)
    self.redis.srem("blog:#{blog_id}:added_users", user_id)
  end


  def self.to_added_blogs(user_id)
    self.redis.smemers("user:#{user_id}:added_blogs").map(&:to_i)
  end

##### likes

  def self.add_post_like(user_id, post_id)
    self.redis.sadd("user:#{user_id}:liked_posts", post_id)
    self.redis.sadd("post:#{post_id}:user_likes", user_id)
  end

  def self.add_blog_like(user_id, blog_id)
    self.redis.sadd("user:#{user_id}:liked_blogs", blog_id)
    self.redis.sadd("blog:#{blog_id}:user_likes", user_id)
  end

  def self.add_comment_like(user_id, comment_id)
    self.redis.sadd("user:#{user_id}:liked_comments", comment_id)
    self.redis.sadd("comment:#{comment_id}:user_comments", user_id)
  end

  def self.remove_post_like(user_id, post_id)
    self.redis.srem("user:#{user_id}:liked_posts", post_id)
    self.redis.srem("post:#{post_id}:user_likes", user_id)
  end

  def self.remove_blog_like(user_id, blog_id)
    self.redis.srem("user:#{user_id}:liked_blogs", blog_id)
    self.redis.srem("blog:#{blog_id}:user_likes", user_id)
  end

  def self.remove_comment_like(user_id, comment_id)
    self.redis.srem("user:#{user_id}:liked_comments", comment_id)
    self.redis.srem("comment:#{comment_id}:user_likes", user_id)
  end

  def self.to_liked_posts(user_id)
    self.redis.smembers("user:#{user_id}:liked_posts")
  end

  def self.to_liked_blogs(user_id)
    self.redis.smembers("user:#{user_id}:liked_blogs")
  end

  def self.to_liked_comments(user_id)
    self.redis.smembers("user:#{user_id}:liked_comments")
  end

  def self.rev_all(user_id, range= -1)
    # posts = []
    # blogs = []
    # comments = []
    # all = []
    self.redis.zrevrange("user:#{user_id}:likes", 0, range) #.each do |f|
    # h = f.map{|f| f.split(":")}
      # type = h[0].constantize
    #   case type
    #   when Post
    #     posts << h[1].to_i
    #   when blog
    #     blogs << h[1].to_i
    #   when Comment
    #     comments << h[1].to_i
      # end
    # p type
    # end
    # all << Post.find(posts) unless posts.empty?
    # all << blog.find(blogs) unless blogs.empty?
    # all << Comment.find(comments) unless comments.empty?
    # p all
  end


##### Comments

  def self.add_post_comment(user_id, post_id)
    self.redis.sadd("user:#{user_id}:commented_posts", post_id)
    self.redis.sadd("post:#{post_id}:user_comments", user_id)
  end

  def self.add_blog_comment(user_id, blog_id)
    self.redis.sadd("user:#{user_id}:commented_blogs", blog_id)
    self.redis.sadd("blog:#{blog_id}:user_comments", user_id)
  end

  def self.remove_post_comment(user_id, post_id)
    self.redis.srem("user:#{user_id}:commented_posts", post_id)
    self.redis.srem("post:#{post_id}:user_comments", user_id)
  end

  def self.remove_blog_comment(user_id, blog_id)
    self.redis.srem("user:#{user_id}:commented_blogs", blog_id)
    self.redis.srem("blog:#{blog_id}:user_comments", user_id)
  end

  def self.get_commented_post_ids(user_id)
    self.redis.smembers("user:#{user_id}:commented_posts")
  end

  def self.get_commented_blog_ids(user_id)
    self.redis.smembers("user:#{user_id}:commented_blogs")
  end

##### Groups
end
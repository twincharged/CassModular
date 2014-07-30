require './app/models/concerns/model_logic'

class User < ModelLogic
  include Cequel::Record

  before_create :set_created_at, :next_class_id
  after_create :create_backup

  key :id, :int
  column :first_name, :text
  column :last_name, :text
  column :created_at, :timestamp

##### Relations

  def posts(range= 10)
  	ids = UserRelation.to_posts(self.id, range)
  	Post.find(ids)
  end

  def blogs
    ids = UserRelation.to_blogs(self.id)
    Blog.find(ids)
  end

  def added_blogs
    ids = UserRelation.to_added_blogs(self.id)
    Blog.find(ids)
  end

  def followers
    ids = UserRelation.to_followers(self.id)
    User.find(ids)
  end

  def following
    ids = UserRelation.to_following(self.id)
    User.find(ids)
  end

  def blocked_users
    ids = UserRelation.to_blocked_users(self.id)
    User.find(ids)
  end

  def liked_posts
    ids = UserRelation.to_liked_posts(self.id)
    Post.find(ids)
  end

  def liked_blogs
    ids = UserRelation.to_liked_blogs(self.id)
    Blog.find(ids)
  end

  def liked_comments
    ids = UserRelation.to_liked_comments(self.id)
    Post.find(ids)
  end

  def liked_blogs
    ids = UserRelation.to_liked_comments(self.id)
    Blog.find(ids)
  end

  def groups
    Group.where(user_id: self.id)
  end

##### Methods

  def post!(attrs)
    attrs[:user_id] = self.id
    PostCreationForm.create(attrs)
  end

  # def comment_on_post!(attrs)
  #   attrs[:user_id] = self.id
  #   CommentCreationForm.create(attrs)
  # end

  # def comment_on_post!(attrs)
  #   attrs[:user_id] = self.id
  #   CommentCreationForm.create(attrs)
  # end

  def create_blog!(attrs)
    attrs[:user_id] = self.id
    BlogCreationForm.create(attrs)
  end

  def create_group!(attrs)
    attrs[:user_id] = self.id
    GroupCreationForm.create(attrs)
  end

  def add_blog!(blog)
    UserRelation.add_blog_user(self.id, blog.id)
  end


  def dismiss_blog!(blog)
    UserRelation.remove_blog_user(self.id, blog.id)
  end


  def follow!(user)
    UserRelation.add_follow(self.id, user.id)
  end

  def following?(user)
    UserRelation.check_following(self.id, user.id)
  end

  def followed_by?(user)
    UserRelation.check_follower(self.id, user.id)
  end

  def unfollow!(user)
    UserRelation.remove_follow(self.id, user.id)
  end

  def follow_feed
    ids = UserRelation.get_follow_feed(self.id)
    Post.find(ids)
    # self.connection.execute("SELECT user FROM users WHERE")
  end

  def block_user!(user)
    UserRelation.add_block(self.id, user.id)
  end

  def unblock_user!(user)
    UserRelation.remove_block(self.id, user.id)
  end

  def like_post!(post)
    UserRelation.add_post_like(self.id, post.id)
  end

  def unlike_post!(post)
    UserRelation.remove_post_like(self.id, post.id)
  end

  def like_blog!(blog)
    UserRelation.add_blog_like(self.id, blog.id)
  end

  def unlike_blog!(blog)
    UserRelation.remove_blog_like(self.id, blog.id)
  end

  def invite_to_group!(group, user_ids)
    UserRelation.add_group_users(group, user_ids)
  end

  def create_backup
    UserAsync.create(user_id: self.id)
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

# has_many :flagged_objects

# has_many :flags_on_self

# has_one :setting 

# has_many :feedbacks

# has_many :notifications 

# has_many :blocks 

# has_many :blocked_objects 


# has_many :posts 

# has_many :hosted_blogs 

# has_many :conversation_users 

# has_many :conversations 

# has_many :messages

# has_many :received_messages 

# has_many :group_users 
# has_many :groups 

# has_many :blog_users 

# has_many :blogs 

# has_many :pending_blog_users 

# has_many :pending_blogs 

# has_many :added_blog_users 

# has_many :added_blogs 

# has_many :dismissed_blog_users 

# has_many :dismissed_blogs 

# has_many :relationships 

# has_many :reverse_relationships 

# has_many :relationships_pending

# has_many :reverse_relationships_pending 

# has_many :followers 

# has_many :followed_users 

# has_many :pending_followers 

# has_many :pending_followed_users 

# has_many :comments 

# has_many :liks 


#   def follow_feed
#   end

#   def near_feed
#   end

#   def hot_near_feed
#   end

#   def blog_feed
#   end

#   def user_feed
#   end


end

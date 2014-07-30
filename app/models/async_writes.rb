require 'json'

class UserAsync
	include Cequel::Record

	key :user_id, :int
	column :followers, :text
	column :following, :text
	column :groups, :text

	##### README ISSUES #####
	def self.update_cassandra_followers(user)
		ids = UserRelation.to_followers(user.id)
		return if ids == nil || ids.empty?
		record = UserAsync.find(user.id)
		record.followers = ids.to_json
		record.save
	end


	def self.update_redis_followers(user)
		record = UserAsync.find(user.id)
		ids = record.followers
		return if ids == nil || ids.empty?
		ids = JSON.parse(ids)
		UserRelation.redis.sadd("user:#{user.id}:followers", ids)
	end


	def self.update_cassandra_following(user)
		ids = UserRelation.to_following(user.id)
		return if ids == nil || ids.empty?
		record = UserAsync.find(user.id)
		record.following = ids.to_json
		record.save
	end


	def self.update_redis_following(user)
		record = UserAsync.find(user.id)
		ids = record.following
		return if ids == nil || ids.empty?
		ids = JSON.parse(ids)
		UserRelation.redis.sadd("user:#{user.id}:following", ids)
	end


	def self.update_cassandra_groups
	end
	def self.update_redis_groups
	end


	def self.update_cassandra_blocks
	end
	def self.update_redis_blocks
	end

end
require './app/relations/concerns/relation_logic'

class GroupRelation < RelationLogic

	def to_group_users(group)
	  self.redis.smembers("user:#{group.user_id}:groups", group.id)
	end

end
class Populate

def self.console
	u = User.create(first_name: 'Joe', last_name: 'Ritchie')
    s = User.create(first_name: 'Maxx', last_name: 'Lownestein')
    e = User.create(first_name: 'Logan', last_name: 'Straub')
    r = User.create(first_name: 'Johnny', last_name: 'Heinkel')

    p = u.post!(body: 'Post1!!', public: true)
    o = u.post!(body: 'Post2!!', public: false, serialized_taggees: [s.id,e.id])
    z = s.post!(body: 'Post3!!', public: false)
    t = s.post!(body: 'Post4!!', public: false)
    i = e.post!(body: 'Post5!!', public: true)
    n = r.post!(body: 'Post6!!', public: true, serialized_taggees: [e.id,r.id])
    g = r.post!(body: 'Post7!!', public: false)


    q = u.create_group!(name: 'BFFFFS!!', serialized_group_users: [s.id,e.id,r.id])
    w = u.create_group!(name: 'Roommate!!', serialized_group_users: [s.id])
    y = e.create_group!(name: 'That kid i hate!!', serialized_group_users: [u.id])
end


end
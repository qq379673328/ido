Object::extend = (objects...) ->
	@[key] = value for key, value of object for object in objects
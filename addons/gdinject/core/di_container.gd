class_name DIContainer
extends RefCounted

var instances: Dictionary

func _init(instances: Dictionary) -> void:
	self.instances = instances

func resolve(key) -> Variant:
	if instances.has(key):
		return instances[key]
	
	push_error("DIContainer: can't resolve key %s" % key)
	return null

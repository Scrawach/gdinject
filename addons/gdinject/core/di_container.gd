class_name DIContainer
extends RefCounted

var services: DIServiceLocator

func _init(services: DIServiceLocator) -> void:
	self.services = services

func resolve(key) -> Variant:
	if services.has(key):
		return services.find(key)
	
	push_error("DIContainer: can't resolve key %s" % key)
	return null

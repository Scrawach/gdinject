class_name DIContainer
extends RefCounted

var services: DIServiceLocator

func _init(services: DIServiceLocator) -> void:
	self.services = services

func resolve(key) -> Variant:
	if key is GDScript:
		return services.find(key.get_global_name())
		
	return services.find(key)

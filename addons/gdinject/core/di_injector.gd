class_name DIInjector
extends RefCounted

var services: DIServiceLocator

func _init(services_id: int) -> void:
	self.services = instance_from_id(services_id)

func find(key) -> Variant:
	return services.find(key)

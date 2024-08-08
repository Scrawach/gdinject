class_name DIContainer
extends RefCounted

var services: DIServiceLocator

func _init(services: DIServiceLocator) -> void:
	self.services = services

func resolve(key) -> Variant:
	return services.find(key)

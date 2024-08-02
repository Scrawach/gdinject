class_name DIServiceLocator
extends RefCounted

var services: Dictionary

func add(key, instance: Variant) -> void:
	services[key] = instance

func has(key) -> bool:
	return services.has(key)

func find(key) -> Variant:
	if services.has(key):
		return services[key]
	
	push_error("DIServiceLocator: not find service with key = %s" % key)
	return null

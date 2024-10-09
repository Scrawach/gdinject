class_name DIBinding
extends RefCounted

var contract: GDScript
var implementation: GDScript
var is_single: bool

func _init(type: GDScript) -> void:
	contract = type
	is_single = true

func to(target: GDScript) -> DIBinding:
	implementation = target
	return self

func as_single() -> DIBinding:
	is_single = true
	return self

func as_transient() -> DIBinding:
	is_single = false
	return self

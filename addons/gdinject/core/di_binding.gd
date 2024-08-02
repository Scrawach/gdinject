class_name DIBinding
extends RefCounted

var contract
var implementation
var is_single: bool

func _init(type) -> void:
	contract = type
	is_single = true

func to(target) -> DIBinding:
	implementation = target
	return self

func as_single() -> DIBinding:
	is_single = true
	return self

func as_transient() -> DIBinding:
	is_single = false
	return self

class_name DIInitMethod
extends RefCounted

var contract_name: String
var contract_type: Resource
var implementation_name: String
var base_script: Script
var argument_names: PackedStringArray

func _init(contract_name: String, implementation_name: String, script: Script) -> void:
	self.contract_name = contract_name
	self.implementation_name = implementation_name
	self.base_script = script
	self.argument_names = []

func set_arguments_names(names: PackedStringArray) -> void:
	argument_names = names

func _to_string() -> String:
	return "Contract: %s; Implementation: %s; Arguments: %s; Base Script: %s" % [
		contract_name, implementation_name, argument_names, base_script]

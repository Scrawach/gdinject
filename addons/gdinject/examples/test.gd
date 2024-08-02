extends Node

func _ready() -> void:
	var services := DIServiceLocator.new()
	services.add(ILogger, ConsoleLogger.new())
	
	var services_id: int = services.get_instance_id()
	var source_code: String = SOURCE_CODES % ["DefaultCommand", services_id, "arg0 = __injector.find(ILogger)", "arg0"]
	
	print(source_code)
	
	var script := GDScript.new()
	script.source_code = source_code
	script.reload()
	
	var instance = script.new() as DefaultCommand
	
	instance.execute()	

const SOURCE_CODES: String = """
extends %s

var __services_id: int = %s
var __injector := DIInjector.new(__services_id)

func _init(%s) -> void:
	super(%s)
"""

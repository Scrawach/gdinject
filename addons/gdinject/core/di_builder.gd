class_name DIBuilder
extends RefCounted

var bindings: Array[DIBinding]

func bind(contract) -> DIBinding:
	var binding := DIBinding.new(contract)
	bindings.append(binding)
	return binding

func build() -> DIContainer:
	var instances := Dictionary()
	
	for binding in bindings:
		var to_load: Script = load(binding.implementation.resource_path)
		for property in to_load.get_script_constant_map():
			print(property)
		print(get_class_name(binding.contract))
		for method in to_load.get_script_method_list():
			if method.name == "_init":
				for arg in method.args:
					print(arg)
	
	return DIContainer.new(instances)

func get_class_name(type: Resource) -> String:
	const CLASS_NAME: String = "class_name"
	const CLASS_NAME_DELIMITER: String = " "
	const CLASS_NAME_CONTENT_INDEX: int = 1
	
	var script_path: String = type.resource_path
	var script: Script = load(script_path) as Script
	var source: String = script.source_code
	var content: PackedStringArray = source.split('\n')
	
	for line in content:
		if line.begins_with(CLASS_NAME):
			return line.split(CLASS_NAME_DELIMITER)[CLASS_NAME_CONTENT_INDEX]
	
	return script.get_instance_base_type()


class_name DIBuilder
extends RefCounted

var bindings: Array[DIBinding]

func bind(contract) -> DIBinding:
	var binding := DIBinding.new(contract)
	bindings.append(binding)
	return binding

func build() -> DIContainer:
	var instances := Dictionary()
	var arguments := Dictionary()
	
	for binding in bindings:
		var to_load: Script = load(binding.implementation.resource_path)
		var contract_name: String = get_class_name(binding.contract)
		var implementation_name: String = get_class_name(binding.implementation)
		var init_method := DIInitMethod.new(contract_name, implementation_name, to_load)
		init_method.contract_type = binding.contract
		arguments[contract_name] = init_method
		
		for method in to_load.get_script_method_list():
			if method.name == "_init":
				var init_arguments: PackedStringArray
				for arg in method.args:
					init_arguments.append(arg.class_name)
				init_method.set_arguments_names(init_arguments)
	
	var services := DIServiceLocator.new()
	var services_id: int = services.get_instance_id()
	
	for argument in arguments.keys():
		var init_method = arguments[argument] as DIInitMethod
		print(init_method)
		var argument_count: int = init_method.argument_names.size()
		var instance: Variant
		
		if argument_count > 0:
			var dependencies: Array = resolve_dependencies(init_method.argument_names, services)
			instance = init_method.base_script.new.bindv(dependencies).call()
		else:
			instance = init_method.base_script.new()
			
		services.add(init_method.contract_name, instance)
	
	return DIContainer.new(services)

static func resolve_dependencies(type_names: PackedStringArray, services: DIServiceLocator) -> Array:
	var dependencies: Array
	for type_name in type_names:
		dependencies.append(services.find(type_name))
	return dependencies

static func get_arguments(count: int) -> String:
	var base_argument_name: String = "arg"
	var result: String = ""
	for index in range(count):
		if index > 0:
			result += ", "
		result += base_argument_name + str(index)
	return result

static func get_class_name(type: Resource) -> String:
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

class_name DIBuilder
extends RefCounted

var bindings: Array[DIBinding]

func bind(contract: GDScript) -> DIBinding:
	var binding := DIBinding.new(contract)
	bindings.append(binding)
	return binding

func build() -> DIContainer:
	var init_methods: Array[DIInitMethod] = get_init_data(bindings)
	var services: DIServiceLocator = create_service_locator(init_methods)
	return DIContainer.new(services)

static func get_init_data(bindings: Array[DIBinding]) -> Array[DIInitMethod]:
	var init_methods: Array[DIInitMethod]
	
	for binding in bindings:
		init_methods.append(create_init_method(binding))
	
	return init_methods

static func create_init_method(binding: DIBinding) -> DIInitMethod:
	var to_load: Script = load(binding.implementation.resource_path)
	var contract_name: String = binding.contract.get_global_name()
	var implementation_name: String = binding.implementation.get_global_name()
	var init_method := DIInitMethod.new(contract_name, implementation_name, to_load)
	init_method.contract_type = binding.contract
	init_method.argument_types = get_argument_types(to_load, "_init")
	return init_method

static func get_argument_types(script: Script, method_name: String) ->PackedStringArray:
	for method in script.get_script_method_list():
		if method.name == method_name:
			var init_arguments: PackedStringArray
			for arg in method.args:
				init_arguments.append(arg.class_name)
			return init_arguments
	return PackedStringArray()

static func create_service_locator(methods: Array[DIInitMethod]) -> DIServiceLocator:
	var services := DIServiceLocator.new()
	
	for init_method in methods:
		var argument_count: int = init_method.argument_types.size()
		var instance: Variant
		
		if argument_count > 0:
			var dependencies: Array = resolve_dependencies(init_method.argument_types, services)
			instance = init_method.base_script.new.bindv(dependencies).call()
		else:
			instance = init_method.base_script.new()
			
		services.add(init_method.contract_name, instance)
	
	return services

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

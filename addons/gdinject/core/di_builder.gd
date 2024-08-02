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
		var to_load = load(binding.implementation.resource_path)
		var logger: Resource = ILogger
		for method in to_load.get_script_method_list():
			if method.name == "_init":
				for arg in method.args:
					print(arg.class_name)
	
	return DIContainer.new(instances)


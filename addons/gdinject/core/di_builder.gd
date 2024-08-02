class_name DIBuilder
extends RefCounted

var bindings: Array[DIBinding]

func bind(contract) -> DIBinding:
	var binding := DIBinding.new(contract)
	bindings.append(binding)
	return binding

func build() -> DIContainer:
	return DIContainer.new()


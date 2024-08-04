extends GutTest

func test_when_resolve_by_contract_then_should_return_instance_binded_with_this_contract() -> void:
	# arrange
	var builder := DIBuilder.new()
	builder.bind(ILogger).to(ConsoleLogger).as_single()
	var container: DIContainer = builder.build()
	
	# act
	var logger = container.resolve(ILogger)
	
	# assert
	assert_not_null(logger)
	assert_true(logger is ConsoleLogger)

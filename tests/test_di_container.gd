extends GutTest

func test_resolve_instance_by_contract() -> void:
	# arrange
	var builder := DIBuilder.new()
	builder.bind(ILogger).to(ConsoleLogger).as_single()
	var container: DIContainer = builder.build()
	
	# act
	var logger = container.resolve(ILogger)
	
	# assert
	assert_not_null(logger)
	assert_true(logger is ConsoleLogger)

func test_resolve_instance_by_contract_with_dependencies() -> void:
	# arrange
	var builder := DIBuilder.new()
	builder.bind(ILogger).to(ConsoleLogger).as_single()
	builder.bind(ICommand).to(DefaultCommand).as_single()
	var container: DIContainer = builder.build()
	
	# act
	var command = container.resolve(ICommand)
	
	# assert
	assert_not_null(command)
	assert_true(command is DefaultCommand)

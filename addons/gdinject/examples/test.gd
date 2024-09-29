extends Node

func _ready() -> void:
	#var callback = DefaultCommand.new.bind("my_tag").bind(logger)
	#var callback = DefaultCommand.new.bindv([logger, "my_tag"])
	#var value = callback.call() as DefaultCommand
	#value.execute()
	#return
	var builder := DIBuilder.new()
	builder.bind(ILogger).to(ConsoleLogger).as_single()
	builder.bind(ICommand).to(DefaultCommand).as_single()
	
	var container: DIContainer = builder.build()
	var command: ICommand = container.resolve("ICommand") as ICommand
	command.execute()

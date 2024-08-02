class_name DefaultCommand
extends ICommand

var logger: ILogger

func _init(logger: ILogger) -> void:
	self.logger = logger

func execute() -> void:
	logger.info("DefaultCommand: Hello, World!")

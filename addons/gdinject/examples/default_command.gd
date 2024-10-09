class_name DefaultCommand
extends ICommand

var logger: ILogger
var tag: String

func _init(logger: ILogger) -> void:
	self.logger = logger

func execute() -> void:
	logger.info("[%s] DefaultCommand: Hello, World!" % tag)

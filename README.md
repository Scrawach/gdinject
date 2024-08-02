> [!WARNING]  
> Work in progress. Right now it's a raw prototype.

# Usage

```gdscript
func _ready() -> void:
	var builder := DIBuilder.new()
	builder.bind(ILogger).to(ConsoleLogger).as_single()
	builder.bind(ICommand).to(DefaultCommand).as_single()
	
	var container: DIContainer = builder.build()
	var command: ICommand = container.resolve(ICommand) as ICommand
	command.execute()
```

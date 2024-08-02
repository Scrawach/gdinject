> [!WARNING]  
> Work in progress. Right now it's a raw prototype. After all, it will be transformed into a unitypackage or something like that.

# Usage

```gdscript
func _ready() -> void:
	var builder := DIBuilder.new()
	builder.bind(ILogger).to(ConsoleLogger).as_single()
	builder.bind(ICommand).to(DefaultCommand).as_single()
	
	var container: DIContainer = builder.build()
	var commnad: ICommand = container.resolve(ICommand) as ICommand
	commnad.execute()
```

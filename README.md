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

# How it works

GdScript does not allow dependencies to be injected into existing classes via the reflection analogy. But you can use another way and create dynamic scripts for each instance, which will be inherited from the original one. In this case, dependencies can be retrieved inside the inheritor using the service locator pattern. Dynamic scripts look something like the following:

```gdscript
extends %s

func _init(services: DIServiceLocator) -> void:
	super(%s)
```

In example, for class `DefaultCommand` with dependency `ILogger`:

```gdscript
class_name DefaultCommand

var logger: ILogger

func _init(logger: ILogger) -> void:
	self.logger = logger
```

Dynamic script for instance looks like:

```gdscript
extends DefaultCommand

func _init(services: DIServiceLocator) -> void:
	super(services.find(ILogger))
```

Such scripts are created dynamically during dependency resolving. So it has a performance overhead.

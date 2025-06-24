extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@onready var target_panel = $"../../esa"

func _on_pressed():
	get_parent().visible = false  # Hides the panel the button is inside
	target_panel.visible = true

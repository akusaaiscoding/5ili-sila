extends Button

var float_amplitude := 2.0
var float_speed := 0.5
var base_position := Vector2()

func _ready():
	base_position = position

func _process(delta):
	position.y = base_position.y + sin(Time.get_ticks_msec() / 1000.0 * float_speed * TAU) * float_amplitude

@onready var target_panel = $"../../end4"

func _on_pressed():
	get_parent().visible = false  # Hides the panel the button is inside
	target_panel.visible = true   # Shows the other panel

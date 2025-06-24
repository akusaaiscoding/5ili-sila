extends CanvasLayer

@onready var name_label = $Background/NameLabel
@onready var text_label = $Background/TextLabel

var dialog_lines = []
var current_index = 0

func _ready():
	visible = false

func show_dialog(lines: Array):
	dialog_lines = lines
	current_index = 0
	visible = true
	show_next_line()

func show_next_line():
	if current_index >= dialog_lines.size():
		hide_dialog()
		return

	var line = dialog_lines[current_index]
	name_label.text = line["speaker"]
	text_label.text = line["text"]

	# TODO (later): emit line["expression"] to character portrait
	current_index += 1

func _input(event):
	if visible and event is InputEventMouseButton and event.pressed:
		show_next_line()

func hide_dialog():
	visible = false

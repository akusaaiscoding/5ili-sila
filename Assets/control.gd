extends Control

@onready var Panel1 = $end1
@onready var Panel2 = $end2
@onready var Panel3 = $end3
@onready var Panel4 = $end4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Panel1.visible = true
	Panel2.visible = false
	Panel3.visible = false
	Panel4.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

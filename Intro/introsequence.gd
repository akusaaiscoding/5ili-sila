extends Control

@onready var Panel1 = $start
@onready var Panel2 = $kadita
@onready var Panel3 = $musya
@onready var Panel4 = $siti
@onready var Panel5 = $adila
@onready var Panel6 = $esa
@onready var Panel7 = $garu
@onready var Panel8 = $end

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Panel1.visible = true
	Panel2.visible = false
	Panel3.visible = false
	Panel4.visible = false
	Panel5.visible = false
	Panel6.visible = false
	Panel7.visible = false
	Panel8.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

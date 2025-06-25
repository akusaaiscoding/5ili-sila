extends Control

var dialog = [
	{"name": "Garu", "text": "Esa, I’m here to break free of your corruption and bring you back!", "emotion": "ang"},
	{"name": "Esa", "text": "Oh no… Garu? Stay away! Or else… I’m gonna… I’ll have to fight you!", "emotion": "esa"},
	{"name": "Garu", "text": "You… Don't want to fight me? Can we resolve this peacefully?", "emotion": "sad"},
	{"name": "Esa", "text": "No!! Just stay away from me! I don’t care what you think, I’m just scared!", "emotion": "esa"},
	{"name": "Garu", "text": "Esa… neither of us can run away from this situation… You’re not yourself right now.", "emotion": "norm"},
	{"name": "Esa", "I’m perfectly fine!! No corruption!! I don’t believe in any of that!": "esa"},
	{"name": "Garu", "text": "Looks like Esa’s in complete denial…", "emotion": "emba"},
	{"name": "Garu", "text": "Esa… you’re corrupted and it’s okay! If you just calm down, remember everything we can just-", "emotion": "sad"},
	{"name": "Esa", "Ahhh!! Go away!": "esa"},
	{"name": "Garu", "text":"Oh no, it’s starting again!", "emotion": "sup"},
	]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"esa": preload("res://Image Assets/sila 1 expressions/Esa_Corrupt.PNG")
}

var dialog_index = 0
var finished = false
var char_index = 0
var typing_speed = 75  # characters per second
var current_text = ""

@onready var charimg = $charimg
@onready var dialogue_text = $RichTextLabel
@onready var name_label = $namelabel

func _ready():
	visible = false
	set_process_input(false)
	load_dialog()

func _input(event):
	if not visible:
		return  # Ignore all input if hidden

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and finished:
		load_dialog()

func _process(delta):
	if Input.is_key_pressed(KEY_G):
		visible = true
		set_process_input(true)

func load_dialog():
	if dialog_index < dialog.size():
		current_text = dialog[dialog_index]["text"]
		dialogue_text.text = current_text
		char_index = 0
		dialogue_text.visible_characters = 0
		finished = false

		var emotion = dialog[dialog_index]["emotion"]
		charimg.texture = emotions[emotion]

		name_label.text = dialog[dialog_index]["name"]

		dialog_index += 1
	else:
		queue_free()

func _physics_process(delta):
	if not finished:
		char_index += typing_speed * delta
		dialogue_text.visible_characters = int(char_index)
		
		if dialogue_text.visible_characters >= current_text.length():
			dialogue_text.visible_characters = current_text.length()
			finished = true

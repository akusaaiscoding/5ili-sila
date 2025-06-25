extends Control

var dialog = [
	{"name": "Kadita", "text": "Garu… You!", "emotion": "kad"},
	{"name": "Garu", "text": "Kadita… What happened to you…", "emotion": "sad"},
	{"name": "Kadita", "text": "You… You left us just as the corruption came about!", "emotion": "kad"},
	{"name": "Kadita", "text": "Trying to play the hero now huh?!", "emotion": "kad"},
	{"name": "Garu", "text": "I.. I didn’t mean to leave you guys. Just come back… like old times! The world needs justice… we need you!", "emotion": "sad"},
	{"name": "Kadita", "text": "This world doesn’t deserve justice…", "emotion": "kad"},
	{"name": "Kadita", "text": "Just like… We. Don’t. Need. You.", "emotion": "kad"},
	{"name": "Garu", "text": "Oh dear.. better watch out for her cotton and rice!!!", "emotion": "tir"}
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"kad": preload("res://Image Assets/sila 5 expressions/Kadita_Corrupt.PNG")
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
	if Input.is_key_pressed(KEY_4):
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

extends Control 

var dialog = [
	{"name": "Garu", "text": "Ugh... where am I.. and.. What happened?", "emotion": "tir"},
	{"name": "Garu", "text": "Wait... where are the others?", "emotion": "sup"},
	{"name": "Garu", "text": "Huh?! My badges.. They're all gone!", "emotion": "sup"},
	{"name": "Garu", "text": "I should go look for a way out... maybe I can find the others..", "emotion": "hap"}
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG")
}

var dialog_index = 0
var finished = false
var char_index = 0
var typing_speed = 75  # characters per second
var current_text = ""

@onready var charimg = $charimg
@onready var dialogue_text = $RichTextLabel
@onready var name_label = $namelabel  # Make sure you have a Label named "NameLabel"

func _ready():
	load_dialog()

func _process(delta):
	if finished and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		current_text = dialog[dialog_index]["text"]
		dialogue_text.text = current_text
		char_index = 0
		dialogue_text.visible_characters = 0
		finished = false

		# Swap character sprite based on emotion
		var emotion = dialog[dialog_index]["emotion"]
		charimg.texture = emotions[emotion]

		# Set character name
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

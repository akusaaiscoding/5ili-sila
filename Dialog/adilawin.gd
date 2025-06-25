extends Control

var dialog = [
	{"name": "Adila", "text": "Yay!! Oh how great it feels to be all nice and clean! Love you always, Garu!", "emotion": "alov"},
	{"name": "Garu", "text": "Hehe, it’s no big deal… I’m glad you can finally speak to me again like usual!", "emotion": "hap"},
	{"name": "Adila", "text": "Oh, I do miss saying silly words like… yippee! Yippee!!", "emotion": "aexc"},
	{"name": "Garu", "text": "Hahah… y-yeah! Yippee?", "emotion": "emba"},
	{"name": "Garu", "text": "A-anyways! Could you help me navigate and get up this tower, Adila?", "emotion": "norm"},
	{"name": "Adila", "text": "Oh, sure thing! I mean, I’ve been the lapdog of this ginormous tower for like, probably forever now!", "emotion": "aups"},
	{"name": "Garu", "text": "Oh that’s uhhhhh... Sorry you had to go through that. Well, can I go see my friend first before we go?", "emotion": "sad"},
	{"name": "Adila", "text": "Okie dokie! But don’t take too long!", "emotion": "anor"},
]

var emotions = {
	"ang": preload("res://Image Assets/garuemo/Garu_Angry.PNG"),
	"emba": preload("res://Image Assets/garuemo/Garu_Embarassed.PNG"),
	"hap": preload("res://Image Assets/garuemo/Garu_Happy.PNG"),
	"norm": preload("res://Image Assets/garuemo/Garu_Normal.PNG"),
	"sad": preload("res://Image Assets/garuemo/Garu_Sad.PNG"),
	"sup": preload("res://Image Assets/garuemo/Garu_Surprised.PNG"),
	"tir": preload("res://Image Assets/garuemo/Garu_Tired_Suspicious.PNG"),
	"aexc": preload("res://Image Assets/sila 2 expressions/Adila_Excited.PNG"),
	"alov": preload("res://Image Assets/sila 2 expressions/Adila_Love.PNG"),
	"anor": preload("res://Image Assets/sila 2 expressions/Adila_Normal.PNG"),
	"aups": preload("res://Image Assets/sila 2 expressions/Adila_Upset_Thinking.PNG")
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
	if Input.is_key_pressed(KEY_U):
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
